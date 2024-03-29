import UIKit

protocol CharacterDetailsViewProtocol: AnyObject, ImageReceiver {
    func displayInfo(adapter: CharacterDetailsAdapter)
    func displayHeader(name: String, statusColor: UIColor, statusDescription: String)
    func displayError()
    func startLoading()
}

final class CharacterDetailsViewController: UIViewController {
    var currentDownloadTask: Cancellable?
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.image = Image.characterPlaceholder.image
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var characterTitle = UILabel.build(type: .largeTitle, color: Color.gray4.color, numberOfLines: 1)
    
    private lazy var statusIndicator: UIView = {
        let view = UIView()
        view.border(radius: Radius.low)
        return view
    }()
    
    private lazy var statusLabel = UILabel.build(type: .title, color: Color.gray3.color)
    
    private lazy var statusBadgeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusIndicator, statusLabel])
        stackView.alignment = .center
        stackView.spacing = Spacing.space2
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [characterTitle, statusBadgeStackView])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space1
        return stackView
    }()
    
    private lazy var gradientView = UIView()
    
    private lazy var characterInfoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Color.background.color
        view.border(radius: Radius.medium)
        return view
    }()
    
    private lazy var infoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = .zero
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.color = Color.green1.color
        return loading
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView(delegate: self)
        view.isHidden = true
        return view
    }()
    
    private var topBarHeight: CGFloat {
       UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    
    private let viewModel: CharacterDetailsViewModelProtocol
    
    init(viewModel: CharacterDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
       super.viewDidLoad()
       buildView()
       viewModel.loadContent()
   }

   override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       applyGradient()
       setupHeaderSize()
   }
   
   private func applyGradient() {
       let gradient = CAGradientLayer()
       gradient.frame = gradientView.bounds
       gradient.colors = [UIColor.black.withAlphaComponent(0.7).cgColor,
                          UIColor.black.withAlphaComponent(0.4).cgColor,
                          UIColor.clear.cgColor]
       gradient.locations = [0, 0.25, 1]
       
       gradientView.layer.sublayers?.removeAll()
       gradientView.layer.insertSublayer(gradient, at: 0)
   }
    
    private func setupHeaderSize() {
        let width = view.frame.width - (Spacing.space3 * 2)
        let height = headerStackView.systemLayoutSizeFitting(CGSize(width: width, height: 0)).height
        headerStackView.height(height)
    }
}

extension CharacterDetailsViewController: ViewSetup {
    func setupConstraints() {
        characterImage.anchor(top: view.topAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor)
        
        characterImage.widthAnchor.constraint(equalTo: characterImage.heightAnchor).isActive = true
        
        characterInfoContainer.anchor(top: characterImage.bottomAnchor,
                                      bottom: view.bottomAnchor,
                                      leading: view.leadingAnchor,
                                      trailing: view.trailingAnchor,
                                      padding: .init(paddingTop: -Spacing.space5))
        
        headerStackView.anchor(top: characterInfoContainer.topAnchor,
                               leading: characterInfoContainer.leadingAnchor,
                               trailing: characterInfoContainer.trailingAnchor,
                               padding: .init(top: Spacing.space3, left: Spacing.space3, bottom: 0, right: Spacing.space3))
        
        gradientView.anchor(top: view.topAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor)
        
        gradientView.heightAnchor.constraint(equalToConstant: topBarHeight).isActive = true
    
        infoTableView.anchor(top: headerStackView.bottomAnchor,
                             bottom: characterInfoContainer.bottomAnchor,
                             leading: characterInfoContainer.leadingAnchor,
                             trailing: characterInfoContainer.trailingAnchor,
                             padding: .init(paddingBottom: Spacing.space2))
        
        errorView.anchor(top: headerStackView.bottomAnchor,
                         bottom: characterInfoContainer.bottomAnchor,
                         leading: characterInfoContainer.leadingAnchor,
                         trailing: characterInfoContainer.trailingAnchor,
                         padding: .init(inset: Spacing.space3))
        
        loadingView.anchor(top: headerStackView.bottomAnchor,
                           bottom: characterInfoContainer.bottomAnchor,
                           leading: characterInfoContainer.leadingAnchor,
                           trailing: characterInfoContainer.trailingAnchor)
        
        statusIndicator.size(12)
    }
    
    func setupHierarchy() {
        view.addSubviews(characterImage, characterInfoContainer, gradientView, loadingView, errorView)
        characterInfoContainer.addSubviews(headerStackView, infoTableView)
    }
    
    func setupStyles() {
        navigationController?.navigationBar.tintColor = .white
        characterTitle.adjustsFontSizeToFitWidth = true
    }
}

extension CharacterDetailsViewController {
    func setImage(_ image: UIImage) {
        characterImage.image = image
    }
}

extension CharacterDetailsViewController: CharacterDetailsViewProtocol {
    func displayInfo(adapter: CharacterDetailsAdapter) {
        loadingView.stopAnimating()
        infoTableView.delegate = adapter
        infoTableView.dataSource = adapter
        
        view.animate { [unowned self] in
            self.infoTableView.reloadData()
        }
    }
    
    func displayHeader(name: String, statusColor: UIColor, statusDescription: String) {
        characterTitle.text = name
        statusIndicator.backgroundColor = statusColor
        statusLabel.text = statusDescription
    }
    
    func displayError() {
        loadingView.stopAnimating()
        view.animate { [unowned self] in
            self.errorView.isHidden = false
        }
    }
    
    func startLoading() {
        loadingView.startAnimating()
    }
}

extension CharacterDetailsViewController: ErrorViewDelegateProtocol {
    func didTapTryAgain() {
        view.animate { [unowned self] in
            self.errorView.isHidden = true
        }
        viewModel.loadContent()
    }
}
