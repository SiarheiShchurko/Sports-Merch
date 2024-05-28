import UIKit
final class TeamAttributesTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "\(TeamAttributesTableViewCell.self)")
        backgroundColor = .white
        selectionStyle = .none
        teamAttributesTableViewCellTargets()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var teamDelegate: TransitObjectsDelegateProtocol?
    
    private var currentAttribute: BrandAttributes?
    
    // Labels
    let nameLabel = SecSimpleLabelRace(text: "",
                                        font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                        numberOfLines: 1,
                                        textAlignment: .left)
    // View
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .appPrimaryColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Buttons
    private let trashButton = SimpleSecImageRaceButtonAts(isSystem: true,
                                                          imgName: "trash.fill",
                                                          color: .appPrimaryColor)
    
}

extension TeamAttributesTableViewCell {
    func set(_ cell: BrandAttributes) {
        currentAttribute = cell
        nameLabel.text = cell.brandName
    }
}

private extension TeamAttributesTableViewCell {
    func addSubviews() {
        addSubview(nameLabel)
        addSubview(separator)
        contentView.addSubview(trashButton)
        NSLayoutConstraint.activate([
            trashButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            trashButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            trashButton.heightAnchor.constraint(equalToConstant: 32),
            trashButton.widthAnchor.constraint(equalToConstant: 32),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trashButton.leadingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

private extension TeamAttributesTableViewCell {
    func teamAttributesTableViewCellTargets() {
        trashButton.addTarget(self, action: #selector(trashDidTapped), for: .touchUpInside)
    }
    
    @objc func trashDidTapped() {
        if let currentAttribute {
            teamDelegate?.delete(currentAttribute)
        }
    }
}
