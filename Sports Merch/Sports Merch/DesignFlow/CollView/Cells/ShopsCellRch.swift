import UIKit
final class ShopsCellRch: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Label
    private let teamNameLabel = SecSimpleLabelRace(text: "",
                                                   textColor: .black,
                                                   font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                                   numberOfLines: 1,
                                                   textAlignment: .center)
    
    private let phoneNumberLabel = SecSimpleLabelRace(text: "",
                                                      textColor: .black.withAlphaComponent(0.7),
                                                   font: .systemFont(ofSize: CGFloat.RaceFontArtSizeSec.secondFontSize),
                                                      numberOfLines: 1,
                                                      textAlignment: .center)
    // Image
    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
}

extension ShopsCellRch {
    func set(_ cell: TeamEachShop) {
        if !cell.imageName.isEmpty {
            loadImage(imageName: cell.imageName) { [ weak self ] data in
                self?.mainImage.image = UIImage(data: data)
            }
        } else {
            mainImage.image = UIImage(named: "emptyStrAvatarEchImg")
        }
        teamNameLabel.text = cell.teamName
        phoneNumberLabel.text = cell.phoneNumber
    }
}

private extension ShopsCellRch {
    func addSubviews() {
        addSubview(mainImage)
        addSubview(teamNameLabel)
        addSubview(phoneNumberLabel)
        NSLayoutConstraint.activate([
            mainImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            mainImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            teamNameLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 8),
            teamNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            teamNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: teamNameLabel.leadingAnchor),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: teamNameLabel.trailingAnchor),
            phoneNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            
        ])
    }
}
