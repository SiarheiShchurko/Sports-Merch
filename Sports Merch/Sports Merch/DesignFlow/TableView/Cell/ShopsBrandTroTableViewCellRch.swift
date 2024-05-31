import UIKit
final class ShopsBrandTroTableViewCellRch: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "\(ShopsBrandTroTableViewCellRch.self)")
        backgroundColor = .white
        selectionStyle = .none
        
        attributesTableView.dataSource = self
        
        teamAttributesTableViewCellTargets()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var editDelegate: EditShopDelegateProtocol?
    
    private var currentBrand: BrandName?
    private var brandIndexPath: Int?
    
    private let attributesRowHeight: CGFloat = {
       return CGFloat.RaceFontArtSizeSec.midleFontSize * 2
    }()
    
    // Labels
    let brandNameLabel = TroSimpleTroLabelRch(text: "",
                                            font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                            numberOfLines: 1,
                                            textAlignment: .left)
    
    // Buttons
    private let editButton = SimpleTroImageRchButtonTro(isSystem: true,
                                                          imgName: "pencil",
                                                          color: .black)
    
    // Table view
    private lazy var attributesTableView = TroTableOrtViewRch(color: .white,
                                                   registerClass: ShopAttributesRtoTableViewCellRch.self,
                                                   cell: "\(ShopAttributesRtoTableViewCellRch.self)",
                                                   rowHeigh: attributesRowHeight,
                                                   separatorStyle: .none)
}

extension ShopsBrandTroTableViewCellRch {
    func set(_ cell: BrandName, with indexPath: Int) {
        currentBrand = cell
        brandIndexPath = indexPath
        
        brandNameLabel.text = cell.brandName
        attributesTableView.reloadData()
    }
}

private extension ShopsBrandTroTableViewCellRch {
    func addSubviews() {
        contentView.addSubview(brandNameLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(attributesTableView)
        NSLayoutConstraint.activate([
            brandNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            brandNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            brandNameLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -4),
            brandNameLabel.heightAnchor.constraint(equalToConstant: 45),
            
            editButton.centerYAnchor.constraint(equalTo: brandNameLabel.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.heightAnchor.constraint(equalToConstant: 32),
            editButton.widthAnchor.constraint(equalToConstant: 32),
            
            attributesTableView.topAnchor.constraint(equalTo: brandNameLabel.bottomAnchor, constant: 4),
            attributesTableView.leadingAnchor.constraint(equalTo: brandNameLabel.leadingAnchor),
            attributesTableView.trailingAnchor.constraint(equalTo: editButton.trailingAnchor),
            attributesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private extension ShopsBrandTroTableViewCellRch {
    func teamAttributesTableViewCellTargets() {
        editButton.addTarget(self, action: #selector(editDidTapped), for: .touchUpInside)
    }
    
    @objc func editDidTapped() {
        if let brandIndexPath,
           let currentBrand {
            editDelegate?.edit(currentBrand, with: brandIndexPath)
        }
    }
}

extension ShopsBrandTroTableViewCellRch: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentBrand {
            return currentBrand.brandAttributes.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let currentBrand,
           !currentBrand.brandAttributes.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ShopAttributesRtoTableViewCellRch.self)", for: indexPath) as? ShopAttributesRtoTableViewCellRch else {
                return UITableViewCell()
            }
            let attribute = currentBrand.brandAttributes[indexPath.row]
            cell.set(attribute)
            return cell
        }
        return UITableViewCell()
    }
}
