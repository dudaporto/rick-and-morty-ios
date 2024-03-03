import UIKit

extension CharacterListCell.Constants {
    enum Insets {
        static let cell = UIEdgeInsets(vertical: Spacing.space1)
    }
    
    enum Size {
        static let image: CGFloat = 120
        static let status: CGFloat = 12
    }
    
    enum Opacity {
        static let border: CGFloat = 0.25
        static let shadow: Float = 0.1
    }
}

final class CharacterListCell: UITableViewCell {
    fileprivate enum Constants { }
    
    weak var currentDownloadTask: Cancellable?
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.border(radius: Radius.medium)
        image.image = Image.characterPlaceholder.image
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return image
    }()
    
    private lazy var nameLabel = UILabel.build(type: .highlightSecondaryTitle, color: Color.gray4.color, numberOfLines: 1)
    
    private lazy var statusIndicator: UIView = {
        let cicledView = UIView()
        cicledView.border(radius: Radius.low)
        return cicledView
    }()
    
    private lazy var statusLabel = UILabel.build(type: .caption, color: Color.gray3.color)
    
    private lazy var statusBadgeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusIndicator, statusLabel])
        stackView.axis = .horizontal
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, statusBadgeStackView])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space1
        return stackView
    }()
    
    private lazy var lastLocationTitle = UILabel.build(
        type: .highlightTertiaryTitle,
        color: Color.gray4.color,
        text: Strings.CharacterList.CharacterCell.lastKnownLocation
    )
    private lazy var lastLocationLabel = UILabel.build(type: .caption, color: Color.gray3.color)
    
    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lastLocationTitle, lastLocationLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, locationStackView])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space2)
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [characterImage, labelsStackView])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var cellContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Color.background.color
        return view
    }()
    
    func setup(with viewModel: CharacterListCellViewModel) {
        nameLabel.text = viewModel.name
        statusIndicator.backgroundColor = viewModel.statusColor
        statusLabel.text = viewModel.statusDescription
        lastLocationLabel.text = viewModel.location
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupStyles()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = Image.characterPlaceholder.image
        currentDownloadTask?.cancel()
    }
}

extension CharacterListCell: ViewSetup {
    func setupConstraints() {
        cellContainer.fitToParent(with: Constants.Insets.cell)
        rootStackView.fitToParent()
    }
    
    func setupHierarchy() {
        contentView.addSubview(cellContainer)
        cellContainer.addSubview(rootStackView)
        characterImage.size(Constants.Size.image)
        statusIndicator.size(Constants.Size.status)
    }
    
    func setupStyles() {
        let shadowOffset = CGSize(width: 0, height: 3)
        cellContainer.border(color: Color.green1.color,
                             width: 1,
                             opacity: Constants.Opacity.border,
                             radius: Radius.medium)
        
        cellContainer.shadow(color: Color.green1.color,
                             opacity: Constants.Opacity.shadow,
                             offset: shadowOffset,
                             radius: 5)
        
        backgroundColor = Color.background.color
        selectionStyle = .none
        nameLabel.adjustsFontSizeToFitWidth = true
    }
}

extension CharacterListCell: ImageReceiver {
    func setImage(_ image: UIImage) {
        characterImage.image = image
    }
}
