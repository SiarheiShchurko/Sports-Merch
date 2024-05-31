import UIKit
final class ShopAttributesRtoTableViewCellRch: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "\(ShopAttributesRtoTableViewCellRch.self)")
        backgroundColor = .white
        selectionStyle = .none
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Labels
    let nameLabel = TroSimpleTroLabelRch(text: "",
                                       font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                       numberOfLines: 1,
                                       textAlignment: .left)
    
    let countLabel = TroSimpleTroLabelRch(text: "",
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
}

extension ShopAttributesRtoTableViewCellRch {
    func set(_ cell: BrandAttributes) {
        nameLabel.text = cell.brandName
        countLabel.text = "\(cell.count ?? 0)"
        
        print("Name label \(cell.brandName)")
    }
}

private extension ShopAttributesRtoTableViewCellRch {
    func addSubviews() {
        addSubview(nameLabel)
        addSubview(separator)
        addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            countLabel.heightAnchor.constraint(equalToConstant: 32),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
