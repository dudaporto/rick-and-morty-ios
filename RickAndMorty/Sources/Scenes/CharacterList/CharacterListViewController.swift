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
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = Constants.Insets.header
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.identifier)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true
        tableView.keyboardDismissMode = .onDrag
        tableView.tableHeaderView = headerStackView
        tableView.sectionHeaderHeight = .zero
        tableView.sectionFooterHeight = .zero
        return tableView
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.color = Color.green1.color
        return loading
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
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
    
    private let viewModel: CharacterListViewModelProtocol
    
    init(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = Color.green1.color
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        let width = view.bounds.width - Spacing.space5
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: width, height: 0)).height
    }
}

// MARK: - ViewSetup
extension CharacterListViewController: ViewSetup {
    func setupConstraints() {
        tableView.fitToParent(with: Constants.Insets.tableView)
        loadingView.fitToParent()
    }
    
    func setupHierarchy() {
        view.addSubviews(tableView, loadingView)
    }
    
    func setupStyles() {
        view.backgroundColor = Color.background.color
    }
}

// MARK: - UITableViewDelegate
//extension CharacterListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch Section(rawValue: indexPath.section) {
//        case .characters:
//            viewModel.didSelectCharacter(at: indexPath.row)
//
//        default:
//            break
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        UITableView.automaticDimension
//    }
//}

// MARK: - CharacterListViewProtocol
extension CharacterListViewController: CharacterListViewProtocol {
    func displayCharacters(adapter: CharacterListAdapter) {
        tableView.dataSource = adapter
        tableView.reloadData()
        tableView.isHidden = false
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
