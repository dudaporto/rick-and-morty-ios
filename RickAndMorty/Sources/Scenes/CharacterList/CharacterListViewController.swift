import UIKit

protocol CharacterListViewProtocol: AnyObject {
    func displayCharacters(adapter: CharacterListAdapter)
    func displaySearchError(name: String)
    func displayServerError()
    func startLoading()
    func stopLoading()
}

extension CharacterListViewController.Constants {
    enum Insets {
        static var tableView = UIEdgeInsets(horizontal: Spacing.space3)
        static var header = UIEdgeInsets(vertical: Spacing.space2)
    }
}

final class CharacterListViewController: UIViewController {
    fileprivate enum Constants { }
    
    private typealias Localizable = Strings.CharacterList
    
    private lazy var subtitleLabel = UILabel.build(type: .title, color: Color.gray2.color, text: Localizable.subtitle)

    private lazy var searchField: UISearchTextField = {
        let search = UISearchTextField()
        search.tintColor = Color.green1.color
        search.placeholder = Localizable.searchBarPlaceholder
        search.delegate = self
        search.returnKeyType = .search
        search.autocorrectionType = .no
        search.backgroundColor = Color.gray0.color
        return search
    }()

    private lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [subtitleLabel, searchField])
        stack.axis = .vertical
        stack.spacing = Spacing.space2
        return stack
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.identifier)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.sectionHeaderHeight = .zero
        tableView.sectionFooterHeight = .zero
        tableView.delaysContentTouches = false
        return tableView
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.color = Color.green1.color
        return loading
    }()
    
    private lazy var notFoundView: CharacterNotFoundView = {
        let view = CharacterNotFoundView()
        view.isHidden = true
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView(delegate: self)
        view.isHidden = true
        return view
    }()
    
    private lazy var errorContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [notFoundView, errorView])
        stackView.axis = .vertical
        stackView.isHidden = true
        return stackView
    }()
    
    private let viewModel: CharacterListViewModelProtocol
    
    init(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.tableHeaderView == nil {
            updateHeader()
            setupErrorContainer()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.title
        buildView()
        viewModel.loadContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = Color.green1.color
    }
    
    private func updateHeader() {
        let width = tableView.frame.width
        headerView.frame.size.height = headerView.systemLayoutSizeFitting(CGSize(width: width, height: 0)).height
        tableView.tableHeaderView = headerView
    }
    
    private func setupErrorContainer() {
        let errorViewSpacing = headerView.frame.size.height + view.safeAreaInsets.top
        errorContainer.topAnchor.constraint(equalTo: tableView.topAnchor, constant: errorViewSpacing).isActive = true
    }
}

// MARK: - ViewSetup
extension CharacterListViewController: ViewSetup {
    func setupConstraints() {
        tableView.fitToParent(with: Constants.Insets.tableView)
        loadingView.fitToParent()
        headerStackView.fitToParent(with: Constants.Insets.header)
        
        errorContainer.anchor(bottom: tableView.bottomAnchor,
                              leading: tableView.leadingAnchor,
                              trailing: tableView.trailingAnchor)
    }
    
    func setupHierarchy() {
        headerView.addSubview(headerStackView)
        errorContainer.addSubviews(notFoundView, errorView)
        view.addSubviews(tableView, loadingView, errorContainer)
    }
    
    func setupStyles() {
        view.backgroundColor = Color.background.color
    }
}

// MARK: - UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch CharacterListAdapter.Section(rawValue: indexPath.section) {
        case .characters:
            guard let cell = tableView.cellForRow(at: indexPath) as? CharacterListCell else {
                return
            }

            cell.shrink { [unowned self] _ in
                self.viewModel.didSelectCharacter(at: indexPath.row)
            }

        case .seeMore:
            let cell = tableView.cellForRow(at: indexPath) as? SeeMoreCell
            cell?.startLoading()
            viewModel.loadMore()
            
        case .none:
            break
        }
    }
}

// MARK: - CharacterListViewProtocol
extension CharacterListViewController: CharacterListViewProtocol {
    func displayCharacters(adapter: CharacterListAdapter) {
        tableView.dataSource = adapter
        
        view.animate { [unowned self] in
            self.errorContainer.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    func displaySearchError(name: String) {
        errorView.isHidden = true
        notFoundView.isHidden = false
        notFoundView.setup(name: name)
        
        view.animate { [unowned self] in
            self.errorContainer.isHidden = false
        }
    }
    
    func displayServerError() {
        errorView.isHidden = false
        notFoundView.isHidden = true
        
        view.animate { [unowned self] in
            self.errorContainer.isHidden = false
        }
    }
    
    func startLoading() {
        loadingView.startAnimating()
    }
    
    func stopLoading() {
        loadingView.stopAnimating()
    }
}

// MARK: - UITextFieldDelegate
extension CharacterListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fieldText = (textField.text ?? "") as NSString
        let newText = fieldText.replacingCharacters(in: range, with: string).trimmingCharacters(in: .whitespaces)
        viewModel.didSearch(newText)
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        viewModel.loadContent()
        view.endEditing(true)
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension CharacterListViewController: ErrorViewDelegateProtocol {
    func didTapTryAgain() {
        searchField.text = ""
        viewModel.loadContent()
    }
}
