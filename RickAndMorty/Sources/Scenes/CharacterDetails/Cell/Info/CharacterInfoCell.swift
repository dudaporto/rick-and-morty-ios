import UIKit

extension CharacterInfoCell.Constants {
    enum Insets {
        static let cell = UIEdgeInsets(horizontal: Spacing.space3, vertical: Spacing.space2)
    }

    enum Size {
        static let icon: CGFloat = 24
    }
}

final class CharacterInfoCell: UITableViewCell {
    fileprivate enum Constants { }
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.tintColor = Color.green1.color
        return image
    }()
    
    private lazy var titleLabel = UILabel.build(type: .highlightSecondaryTitle, color: Color.gray2.color, numberOfLines: 1)

    private lazy var descriptionLabel = UILabel.build(type: .title, color: Color.gray2.color, numberOfLines: 1)
    
    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.spacing = Spacing.space1
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [icon, textsStackView])
        stackView.alignment = .leading
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = Constants.Insets.cell
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.green1.color
        view.alpha = 0.15
        return view
    }()
    
    func setup(viewModel: CharacterInfoViewModel) {
        icon.image = viewModel.aboutSectionConfig.icon
        titleLabel.text = viewModel.aboutSectionConfig.title
        separatorView.isHidden = viewModel.aboutSectionConfig.hideSeparatorView
        descriptionLabel.text = viewModel.description
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension CharacterInfoCell: ViewSetup {
    func setupConstraints() {
        icon.size(Constants.Size.icon)
        
        rootStackView.anchor(top: contentView.topAnchor,
                             bottom: separatorView.topAnchor,
                             leading: contentView.leadingAnchor,
                             trailing: contentView.trailingAnchor)
        
        separatorView.anchor(bottom: contentView.bottomAnchor,
                             leading: contentView.leadingAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(paddingLeft: Spacing.space3))
        
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func setupHierarchy() {
        contentView.addSubviews(rootStackView, separatorView)
    }
    
    func setupStyles() {
        backgroundColor = Color.background.color
        selectionStyle = .none
    }
}
