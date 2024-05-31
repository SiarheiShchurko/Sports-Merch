import UIKit

protocol EditShopDelegateProtocol: AnyObject {
    func openShopForEdit(with indexPath: Int)
    func openNewBrandVc(with indexPath: Int)
    func edit(_ currentBrand: BrandName, with indexPath: Int)
}

final class ShopsTroCellRch: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        
        brandsNameTableView.dataSource = self
        
        shopCellTarget()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var editShopDelegate: EditShopDelegateProtocol?
    
    private var currentShop: Shop?
    private var shopIndexPath: Int?
    
    private let brandRowHeight: CGFloat = {
        CGFloat.RaceFontArtSizeSec.mainFontSize * 8
    }()
    
    // Label
    private let nameShopLabel = TroSimpleTroLabelRch(text: "",
                                                   textColor: .black,
                                                   font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                                   numberOfLines: 2,
                                                   textAlignment: .left)
    
    private let addressLabel = TroSimpleTroLabelRch(text: "",
                                                  textColor: .black,
                                                  font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.secondFontSize),
                                                  numberOfLines: 0,
                                                  textAlignment: .left)
    
    private let phoneNumberLabel = TroSimpleTroLabelRch(text: "",
                                                      textColor: .black.withAlphaComponent(0.7),
                                                      font: .systemFont(ofSize: CGFloat.RaceFontArtSizeSec.secondFontSize),
                                                      numberOfLines: 1,
                                                      textAlignment: .left)
    // Image
    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Buttons
    private let editButton = SimpleTroImageRchButtonTro(isSystem: true,
                                                         imgName: "pencil",
                                                         color: .lightGray,
                                                         backgroundClr: .white)
    
    private let addBrandButton = RchsPrimaryTopButtonTro(title: "Add")
    
    // TableView
    private lazy var brandsNameTableView = TroTableOrtViewRch(color: .white,
                                                         registerClass: ShopsBrandTroTableViewCellRch.self,
                                                         cell: "\(ShopsBrandTroTableViewCellRch.self)",
                                                         rowHeigh: brandRowHeight,
                                                         separatorStyle: .none)
}

extension ShopsTroCellRch {
    func set(_ cell: Shop, indexPath: Int) {
        currentShop = cell
        shopIndexPath = indexPath
        
        if cell.imageName == "defaultShopImg" {
            mainImage.image = UIImage(named: cell.imageName)
        } else if !cell.imageName.isEmpty {
            loadSorImageRch(imageName: cell.imageName) { [ weak self ] data in
                self?.mainImage.image = UIImage(data: data)
            }
        } else {
            mainImage.image = UIImage(named: "emptyStrAvatarEchImg")
        }
        
        nameShopLabel.text = cell.shopName
        addressLabel.text = cell.address
        phoneNumberLabel.text = cell.phoneNumber
        
        brandsNameTableView.reloadData()
        
    }
}

private extension ShopsTroCellRch {
    func addSubviews() {
        addSubview(mainImage)
        addSubview(nameShopLabel)
        addSubview(addressLabel)
        addSubview(phoneNumberLabel)
        addSubview(editButton)
        addSubview(addBrandButton)
        addSubview(brandsNameTableView)
        NSLayoutConstraint.activate([
            mainImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            mainImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            mainImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            nameShopLabel.topAnchor.constraint(equalTo: mainImage.topAnchor),
            nameShopLabel.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 4),
            nameShopLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -4),
            
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            editButton.topAnchor.constraint(equalTo: mainImage.topAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 16),
            editButton.heightAnchor.constraint(equalToConstant: 16),
            
            addressLabel.topAnchor.constraint(equalTo: nameShopLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: nameShopLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: editButton.trailingAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: nameShopLabel.leadingAnchor),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: nameShopLabel.trailingAnchor),
            
            addBrandButton.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 32),
            addBrandButton.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            addBrandButton.trailingAnchor.constraint(equalTo: editButton.trailingAnchor),
            addBrandButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08),
            
            brandsNameTableView.topAnchor.constraint(equalTo: addBrandButton.bottomAnchor, constant: 16),
            brandsNameTableView.leadingAnchor.constraint(equalTo: addBrandButton.leadingAnchor),
            brandsNameTableView.trailingAnchor.constraint(equalTo: addBrandButton.trailingAnchor),
            brandsNameTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}


private extension ShopsTroCellRch {
    func shopCellTarget() {
        addBrandButton.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonDidTapped), for: .touchUpInside)
    }
}

// User actions
private extension ShopsTroCellRch {
    @objc func editButtonDidTapped() {
        if let shopIndexPath {
            editShopDelegate?.openShopForEdit(with: shopIndexPath)
        }
    }
    
    @objc func addButtonDidTapped() {
        if let shopIndexPath {
            editShopDelegate?.openNewBrandVc(with: shopIndexPath)
        }
    }
}

extension ShopsTroCellRch: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentShop?.brandName.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let currentShop {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ShopsBrandTroTableViewCellRch.self)", for: indexPath) as? ShopsBrandTroTableViewCellRch else {
                return UITableViewCell()
            }
            
           
            let brand = currentShop.brandName[indexPath.row]
            cell.editDelegate = self
            cell.set(brand, with: indexPath.row)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ShopsTroCellRch: EditShopDelegateProtocol {
    func openShopForEdit(with indexPath: Int) {
        print("MOCK")
    }
    
    func openNewBrandVc(with indexPath: Int) {
        print("MOCK")
    }
    
    func edit(_ currentBrand: BrandName, with indexPath: Int) {
        if let shopIndexPath {
            editShopDelegate?.edit(currentBrand, with: shopIndexPath)
        }
    }
}
