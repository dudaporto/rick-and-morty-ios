 import UIKit

protocol ErrorViewDelegateProtocol: AnyObject {
    func didTapTryAgain()
}

final class ErrorView: UIView {
    private typealias Localizable = Strings.Error
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: Image.iconError.image)
        image.tintColor = Color.green1.color
        image.contentMode = .center
        return image
    }()
    
    private lazy var titleLabel = UILabel.build(type: .highlightSecondaryTitle, color: Color.gray4.color, text: Localizable.title)
    private lazy var subtitleLabel = UILabel.build(type: .subtitle, color: Color.gray2.color, text: Localizable.message)
    
    private lazy var tryAgainButton: Button = {
        let button = Button()
        button.text = Localizable.tryAgain
        button.addTarget(self, action: #selector(didTapTryAgain), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [image, titleLabel, subtitleLabel, tryAgainButton])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private weak var delegate: ErrorViewDelegateProtocol?
    
    init(delegate: ErrorViewDelegateProtocol) {
        self.delegate = delegate
        super.init(frame: .zero)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    @objc
    private func didTapTryAgain() {
        delegate?.didTapTryAgain()
    }
}

extension ErrorView: ViewSetup {
    func setupConstraints() {
        stackView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(paddingTop: Spacing.space5))
    }
    
    func setupHierarchy() {
        addSubview(stackView)
    }
    
    func setupStyles() {
        backgroundColor = .clear
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
    }
}
