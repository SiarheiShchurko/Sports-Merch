import UIKit
final class TeamsRtoCellRch: UICollectionViewCell {
    
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
    private let teamNameLabel = TroSimpleTroLabelRch(text: "",
                                                   textColor: .black,
                                                   font: .boldSystemFont(ofSize: CGFloat.RchsFontSorSizeTro.midleFontSize),
                                                   numberOfLines: 1,
                                                   textAlignment: .center)
    
    private let phoneNumberLabel = TroSimpleTroLabelRch(text: "",
                                                      textColor: .black.withAlphaComponent(0.7),
                                                   font: .systemFont(ofSize: CGFloat.RchsFontSorSizeTro.secondFontSize),
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

extension TeamsRtoCellRch {
    func set(_ cell: SorTeamRch) {
        if !cell.imageName.isEmpty {
            loadSorImageRch(imageName: cell.imageName) { [ weak self ] data in
                self?.mainImage.image = UIImage(data: data)
            }
        } else {
            mainImage.image = UIImage(named: "emptyStrAvatarEchImg")
        }
        teamNameLabel.text = cell.teamName
        phoneNumberLabel.text = cell.phoneNumber
    }
}

private extension TeamsRtoCellRch {
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
