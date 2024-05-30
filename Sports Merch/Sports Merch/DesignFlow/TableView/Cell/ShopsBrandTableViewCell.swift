import UIKit
final class ShopsBrandTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "\(ShopsBrandTableViewCell.self)")
        backgroundColor = .gray
        selectionStyle = .none
        
        attributesTableView.dataSource = self
        attributesTableView.delegate = self
        
        teamAttributesTableViewCellTargets()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var editDelegate: EditShopDelegateProtocol?
    
    private var currentBrand: BrandName?
    
    // Labels
    let brandNameLabel = SecSimpleLabelRace(text: "",
                                            font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                            numberOfLines: 1,
                                            textAlignment: .left)
    // Buttons
    private let editButton = SimpleSecImageRaceButtonAts(isSystem: true,
                                                          imgName: "pencil",
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
        
        attributesTableView.reloadData()
    }
}

private extension ShopsBrandTableViewCell {
    func addSubviews() {
        contentView.addSubview(brandNameLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(attributesTableView)
        NSLayoutConstraint.activate([
            brandNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            brandNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            brandNameLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -4),
            brandNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            editButton.centerYAnchor.constraint(equalTo: brandNameLabel.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.heightAnchor.constraint(equalToConstant: 32),
            editButton.widthAnchor.constraint(equalToConstant: 32),
            
            attributesTableView.topAnchor.constraint(equalTo: brandNameLabel.bottomAnchor, constant: 8),
            attributesTableView.leadingAnchor.constraint(equalTo: brandNameLabel.leadingAnchor),
            attributesTableView.trailingAnchor.constraint(equalTo: editButton.trailingAnchor),
            attributesTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

private extension ShopsBrandTableViewCell {
    func teamAttributesTableViewCellTargets() {
        editButton.addTarget(self, action: #selector(editDidTapped), for: .touchUpInside)
    }
    
    @objc func editDidTapped() {
           
    }
}

extension ShopsBrandTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("FirstIteration")
        if let currentBrand {
            print("SecondIteration \(currentBrand)")
            return currentBrand.brandAttributes.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Current brand \(currentBrand)")
        if let currentBrand {
            print("Current brand \(currentBrand)")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ShopAttributesTableViewCell.self)", for: indexPath) as? ShopAttributesTableViewCell else {
                return UITableViewCell()
            }
            let attribute = currentBrand.brandAttributes[indexPath.row]
            print("Attribute \(attribute)")
            cell.set(attribute)
            return cell
        }
        print("Cell")
        return UITableViewCell()
    }
}

extension ShopsBrandTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}
