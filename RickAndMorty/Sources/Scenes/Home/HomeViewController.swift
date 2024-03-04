import UIKit

final class HomeViewController: UIViewController {
    private typealias Localizable = Strings.Home
    
    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView(image: Image.homePoster.image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.build(type: .largeTitle, color: Color.gray4.color, text: Localizable.title)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel.build(type: .subtitle, color: Color.gray2.color, text: Localizable.appDescription)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var charactersButton: Button = {
        let button = Button()
        button.text = Localizable.charactersButtonTitle
        button.addTarget(self, action: #selector(showCharacterList), for: .touchUpInside)
        return button
    }()
    
    private lazy var welcomeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            posterImage, titleLabel, descriptionLabel, charactersButton
        ])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space4)
        return stackView
    }()
    
    private lazy var developedLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Localizable.developed.withBoldText(text: Localizable.developedBoldFragment,
                                                                  regularFont: Typography.caption.font,
                                                                  boldFont: Typography.highlightTertiaryTitle.font)
        label.textColor = Color.gray2.color
        return label
    }()
    
    private lazy var githubIcon: UIImageView = {
        let image = UIImageView(image: Image.github.image)
        image.tintColor = Color.gray4.color
        return image
    }()
    
    private lazy var developedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [developedLabel, githubIcon])
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var poweredLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.caption.font
        label.attributedText = Localizable.powered.withBoldText(text: Localizable.poweredBoldFragment,
                                                                regularFont: Typography.caption.font,
                                                                boldFont: Typography.highlightTertiaryTitle.font)
        label.textColor = Color.gray2.color
        return label
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [developedStackView, poweredLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space3)
        return stackView
    }()
    
    private let coordinator: CoordinatorProtocol
    
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = ""
    }
    
    @objc
    private func showCharacterList() {
        coordinator.start(event: .characterList)
    }
}

extension HomeViewController: ViewSetup {
    func setupConstraints() {
        welcomeStackView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(paddingTop: Spacing.space4)
        )
        
        footerStackView.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor
        )
        
        posterImage.height(270)
        githubIcon.size(20)
    }
    
    func setupHierarchy() {
        view.addSubviews(welcomeStackView, footerStackView)
    }
    
    func setupStyles() {
        view.backgroundColor = Color.background.color
    }
}
