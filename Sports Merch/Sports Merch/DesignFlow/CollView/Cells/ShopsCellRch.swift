import UIKit
final class ShopsCellRch: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        
        brandsNameTableView.dataSource = self
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var currentShop: Shop?
    // Label
    private let nameShopLabel = SecSimpleLabelRace(text: "",
                                                   textColor: .black,
                                                   font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                                   numberOfLines: 2,
                                                   textAlignment: .left)
    
    private let addressLabel = SecSimpleLabelRace(text: "",
                                                  textColor: .black,
                                                  font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.secondFontSize),
                                                  numberOfLines: 0,
                                                  textAlignment: .left)
    
    private let phoneNumberLabel = SecSimpleLabelRace(text: "",
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
    private let editButton = SimpleSecImageRaceButtonAts(isSystem: true,
                                                         imgName: "pencil",
                                                         color: .lightGray,
                                                         backgroundClr: .white)
    
    private let addBrandButton = ClasPrimarySecButtonRace(title: "Add")
    
    // TableView
    private let brandsNameTableView = TraTableGniViewArt(color: .white,
                                                         registerClass: ShopsBrandTableViewCell.self,
                                                         cell: "\(ShopsBrandTableViewCell.self)",
                                                         rowHeigh: UITableView.automaticDimension,
                                                         separatorStyle: .none)
}

extension ShopsCellRch {
    func set(_ cell: Shop) {
        currentShop = cell
        
        if !cell.imageName.isEmpty {
            loadImage(imageName: cell.imageName) { [ weak self ] data in
                self?.mainImage.image = UIImage(data: data)
            }
        } else {
            mainImage.image = UIImage(named: "emptyStrAvatarEchImg")
        }
        
        nameShopLabel.text = cell.teamName
        addressLabel.text = cell.address
        phoneNumberLabel.text = cell.phoneNumber
    }
}

private extension ShopsCellRch {
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
            
            phoneNumberLabel.topAnchor.constraint(equalTo: nameShopLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: nameShopLabel.leadingAnchor),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: nameShopLabel.trailingAnchor),
            phoneNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
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

extension ShopsCellRch: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentShop?.brandName.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let currentShop {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ShopsBrandTableViewCell.self)", for: indexPath) as? ShopsBrandTableViewCell else {
                return UITableViewCell()
            }
            let brand = currentShop.brandName[indexPath.row]
            cell.set(brand)
            return cell
        }
        return UITableViewCell()
    }
}
