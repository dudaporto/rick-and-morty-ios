import UIKit

final class TitleHeaderView: UIView {
    private lazy var titleLabel = UILabel.build(type: .highlightSecondaryTitle, color: Color.gray3.color)

    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension TitleHeaderView: ViewSetup {
    func setupConstraints() {
        titleLabel.fitToParent(with: .init(inset: Spacing.space2))
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupStyles() {
        backgroundColor = Color.background.color
    }
}
