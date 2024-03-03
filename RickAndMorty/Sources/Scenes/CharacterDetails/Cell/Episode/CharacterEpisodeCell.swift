import UIKit

final class CharacterEpisodeCell: UITableViewCell {
    private lazy var episodeLabel = UILabel.build(type: .highlightSecondaryTitle, color: Color.green1.color, numberOfLines: 1)

    private lazy var episodeNameLabel = UILabel.build(type: .title, color: Color.gray2.color, numberOfLines: 1)
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [episodeLabel, episodeNameLabel])
        stackView.spacing = Spacing.space1
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space3)
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.green1.color
        view.alpha = 0.15
        return view
    }()
    
    func setup(viewModel: CharacterEpisodeViewModel) {
        episodeLabel.text = viewModel.episodeCode
        episodeNameLabel.text = viewModel.name
        separatorView.isHidden = viewModel.hideSeparatorView
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension CharacterEpisodeCell: ViewSetup {
    func setupConstraints() {
        episodeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        episodeNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        rootStackView.anchor(top: contentView.topAnchor,
                             bottom: separatorView.topAnchor,
                             leading: contentView.leadingAnchor,
                             trailing: contentView.trailingAnchor)
        
        separatorView.anchor(bottom: contentView.bottomAnchor,
                             leading: contentView.leadingAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(paddingLeft: Spacing.space3))
        
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupHierarchy() {
        contentView.addSubviews(rootStackView, separatorView)
    }
    
    func setupStyles() {
        backgroundColor = Color.background.color
        selectionStyle = .none
    }
}
