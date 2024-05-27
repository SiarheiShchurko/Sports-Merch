import UIKit
import StoreKit

final class RaceSettingsArtModule: UIViewController {
    
//    // Buttons
//    private let rateAppButton = RaceSettingAtsButtonSec(titleButton: "Rate app",
//                                                        buttonImage: UIImage(systemName: "star.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal) ?? UIImage())
//    
//    private let shareButton = RaceSettingAtsButtonSec(titleButton: "Share app",
//                                                      buttonImage: UIImage(systemName: "square.and.arrow.up.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal) ?? UIImage())
//    
//    private let usagePolicyButton = RaceSettingAtsButtonSec(titleButton: "Usage Policy",
//                                                            buttonImage: UIImage(systemName: "list.bullet.rectangle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal) ?? UIImage())
//    // Labels
//    private let mainLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Settings"
//        label.textColor = .white
//        label.textAlignment  = .left
//        label.font = .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.mainFontSize)
//        return label
//    }()
//    
//    // Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .appMainBckgrd
//        addTarhets()
//        constraints()
//    }
//    
//    func constraints() {
//        view.addSubview(mainLabel)
//        view.addSubview(shareButton)
//        view.addSubview(rateAppButton)
//        view.addSubview(usagePolicyButton)
//        NSLayoutConstraint.activate([
//            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            shareButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
//            shareButton.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
//            shareButton.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor),
//            shareButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.14),
//            
//            rateAppButton.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 16),
//            rateAppButton.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
//            rateAppButton.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor),
//            rateAppButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.14),
//            
//            usagePolicyButton.topAnchor.constraint(equalTo: rateAppButton.bottomAnchor, constant: 16),
//            usagePolicyButton.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
//            usagePolicyButton.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor),
//            usagePolicyButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.14)
//        ])
//    }
//    func addTarhets() {
//        rateAppButton.addTarget(self, action: #selector(rateAppButtonTapped), for: .touchUpInside)
//        usagePolicyButton.addTarget(self, action: #selector(usagePolicyButtonTapped), for: .touchUpInside)
//        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
//        
//    }
//    
//    @objc func rateAppButtonTapped() {
//        if #available(iOS 14.0, *),
//           let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
//            DispatchQueue.main.async {
//                SKStoreReviewController.requestReview(in: scene)
//            }
//        } else {
//            SKStoreReviewController.requestReview()
//        }
//    }
//    
//    @objc func usagePolicyButtonTapped() {
//        if let url = URL(string: "https://docs.google.com/document/d/1TkaaNvtbihibWyU_Fg1TykOS7_reNNUW7ZxHDkRQgvI/edit?usp=sharing") {
//            let usageSuitsPolicyVC = UsageRacePolicyScreenSec(url: url)
//            navigationController?.pushViewController(usageSuitsPolicyVC, animated: true)
//        }
//    }
//    
//    @objc func shareButtonTapped() {
//        if let url = URL(string: "https://apps.apple.com/us/app/race-stats/id6502910004") {
//            
//            let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
//            
//            if RaceDefltsAtsServiceCes.secUsrRaceDvcAts != .phone,
//               let popoverController = activityController.popoverPresentationController {
//                popoverController.sourceView = shareButton
//                popoverController.sourceRect = shareButton.bounds
//            }
//            
//            present(activityController, animated: true)
//        }
//    }
}
