import UIKit

final class CharacterNotFoundView: UIView {
    private typealias Localizable = Strings.CharacterList.NotFound
    
    private lazy var infoImage = UIImageView(image: Image.jerryShrug.image)

    private lazy var titleLabel = UILabel.build(type: .highlightSecondaryTitle, color: Color.gray4.color)
    
    private lazy var subtitleLabel = UILabel.build(type: .caption, color: Color.gray2.color, text: Localizable.subtitle)
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space1
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoImage, labelsStackView])
        stackView.alignment = .center
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    func setup(name: String) {
        titleLabel.text = Localizable.title(name)
    }
    
    init() {
        super.init(frame: .zero)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension CharacterNotFoundView: ViewSetup {
    func setupConstraints() {
        rootStackView.fitToParent(with: .init(inset: Spacing.space1))
        infoImage.size(80)
    }
    
    func setupHierarchy() {
        addSubview(rootStackView)
    }
    
    func setupStyles() {
        backgroundColor = .clear
    }
}
