import UIKit
final class PartipiantsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "\(PartipiantsTableViewCell.self)")
        backgroundColor = .white
        selectionStyle = .none
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Labels
    let dateLabel = SecSimpleLabelRace(text: "",
                                       textColor: .black.withAlphaComponent(0.8),
                                       font: .systemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                       textAlignment: .center)
    
    let partipiantNameLabel = SecSimpleLabelRace(text: "",
                                        font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.mainFontSize),
                                        numberOfLines: 2,
                                        textAlignment: .center)
    
    let victoriesLabel = SecSimpleLabelRace(text: "",
                                            numberOfLines: 2,
                                            textAlignment: .center)
    
    // Views
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appMainBckgrd
        return view
    }()
    
    private let masksView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
}

//extension PartipiantsTableViewCell {
 //   func set(_ participants: Participants) {
//
//        set(imageCell: participants.imageName)
//        
//        dateLabel.text = participants.age + " " + "years old"
//        partipiantNameLabel.text = "\(participants.name)\n\(participants.surname)"
//        
//        victoriesLabel.setSecLabelRaceTextArt(firstLine: "Victories",
//                                              secondLine: participants.pureWins,
//                                              firstLineFontSize: CGFloat.RaceFontArtSizeSec.midleFontSize,
//                                              secondLineFontSize: CGFloat.RaceFontArtSizeSec.mainFontSize,
//                                              firstLineTextColor: .secondTextColor,
//                                              secondLineTextColor: .black)
//    }
//}

private extension PartipiantsTableViewCell {
    func addSubviews() {
        addSubview(separatorView)
        addSubview(masksView)
        addSubview(mainImage)
        addSubview(dateLabel)
        addSubview(partipiantNameLabel)
        addSubview(victoriesLabel)
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 32),
            
            masksView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor),
            masksView.leadingAnchor.constraint(equalTo: leadingAnchor),
            masksView.trailingAnchor.constraint(equalTo: trailingAnchor),
            masksView.heightAnchor.constraint(equalToConstant: 16),
            
            mainImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            mainImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            victoriesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            victoriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            victoriesLabel.widthAnchor.constraint(equalToConstant: 100),
            
            partipiantNameLabel.topAnchor.constraint(equalTo: mainImage.topAnchor),
            partipiantNameLabel.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 4),
            partipiantNameLabel.trailingAnchor.constraint(equalTo: victoriesLabel.leadingAnchor, constant: -4),
            
            dateLabel.topAnchor.constraint(equalTo: partipiantNameLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 4),
            dateLabel.trailingAnchor.constraint(equalTo: victoriesLabel.leadingAnchor, constant: -4)
        ])
    }
}

private extension PartipiantsTableViewCell {
    func set(imageCell: String) {
        DispatchQueue.global(qos: .userInitiated).sync { [ weak self ] in
            if let coverId = UserDefaults.standard.object(forKey: imageCell) as? String,
               let imgData = Data(base64Encoded: coverId, options: .ignoreUnknownCharacters) {
               
                    self?.mainImage.image = UIImage(data: imgData)
                
            } else {
                    self?.mainImage.image = UIImage(named: "emptyEcAvatar")
                
            }
        }
    }
}
