import UIKit
final class ShopsBrandTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "\(ShopsBrandTableViewCell.self)")
        backgroundColor = .white
        selectionStyle = .none
        
        attributesTableView.dataSource = self
        
        teamAttributesTableViewCellTargets()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var currentBrand: BrandName?
    
    // Labels
    let brandNameLabel = SecSimpleLabelRace(text: "",
                                            font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                            numberOfLines: 1,
                                            textAlignment: .left)
    // Buttons
    private let editButton = SimpleSecImageRaceButtonAts(isSystem: true,
                                                          imgName: "pencil.fill",
                                                          color: .black)
    
    // Table view
    private let attributesTableView = TraTableGniViewArt(color: .white,
                                                   registerClass: ShopAttributesTableViewCell.self,
                                                   cell: "\(ShopAttributesTableViewCell.self)",
                                                   rowHeigh: UITableView.automaticDimension,
                                                   separatorStyle: .none)
}

extension ShopsBrandTableViewCell {
    func set(_ cell: BrandName) {
        currentBrand = cell
        brandNameLabel.text = cell.brandName
    }
}

private extension ShopsBrandTableViewCell {
    func addSubviews() {
        addSubview(brandNameLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(attributesTableView)
        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: brandNameLabel.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            editButton.heightAnchor.constraint(equalToConstant: 32),
            editButton.widthAnchor.constraint(equalToConstant: 32),
            
            brandNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            brandNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            brandNameLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -4),
            brandNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            attributesTableView.topAnchor.constraint(equalTo: brandNameLabel.bottomAnchor, constant: 8),
            attributesTableView.leadingAnchor.constraint(equalTo: brandNameLabel.leadingAnchor),
            attributesTableView.trailingAnchor.constraint(equalTo: editButton.trailingAnchor),
            attributesTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

private extension ShopsBrandTableViewCell {
    func teamAttributesTableViewCellTargets() {
        editButton.addTarget(self, action: #selector(editDidTapped), for: .touchUpInside)
    }
    
    @objc func editDidTapped() {
        //        if let currentAttribute {
        //            teamDelegate?.delete(currentAttribute)
        //        }
    }
}

extension ShopsBrandTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentBrand?.brandAttributes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let currentBrand {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ShopAttributesTableViewCell.self)", for: indexPath) as? ShopAttributesTableViewCell else {
                return UITableViewCell()
            }
            let attribute = currentBrand.brandAttributes[indexPath.row]
            cell.set(attribute)
            return cell
        }
        return UITableViewCell()
    }
}
