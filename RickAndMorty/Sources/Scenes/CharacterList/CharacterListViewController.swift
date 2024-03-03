import UIKit

protocol CharacterListViewProtocol: AnyObject {
    func displayCharacters(adapter: CharacterListAdapter)
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
        return tableView
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.color = Color.green1.color
        return loading
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
        updateHeader()
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
    }
    
    private func updateHeader() {
        let width = tableView.frame.width
        headerView.frame.size.height = headerView.systemLayoutSizeFitting(CGSize(width: width, height: 0)).height
        tableView.tableHeaderView = headerView
    }
}

// MARK: - ViewSetup
extension CharacterListViewController: ViewSetup {
    func setupConstraints() {
        tableView.fitToParent(with: Constants.Insets.tableView)
        loadingView.fitToParent()
        headerStackView.fitToParent(with: Constants.Insets.header)
    }
    
    func setupHierarchy() {
        headerView.addSubview(headerStackView)
        view.addSubviews(tableView, loadingView)
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
            viewModel.didSelectCharacter(at: indexPath.row)

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
        
        UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve) {
            self.tableView.reloadData()
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
        let newText = fieldText.replacingCharacters(in: range, with: string)
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
