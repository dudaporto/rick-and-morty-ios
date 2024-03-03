import UIKit

final class SeeMoreCell: UITableViewCell {
    private lazy var button: Button = {
        let button = Button()
        button.text = Strings.CharacterList.seeMoreCharacters
        button.isUserInteractionEnabled = false
        return button
    }()
    
    func startLoading() {
        button.startLoading()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SeeMoreCell: ViewSetup {
    func setupConstraints() {
        button.fitToParent(with: .init(horizontal: .zero, vertical: Spacing.space3))
    }
    
    func setupHierarchy() {
        contentView.addSubview(button)
    }
    
    func setupStyles() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
