import UIKit
import StoreKit

final class RchSetSorScrTop: UIViewController {
        
        private let preffers: [EthereTypeUell] = [
            EthereTypeUell(imageName: "square.and.arrow.up.fill", itemName: "Share app"),
            EthereTypeUell(imageName: "star.fill", itemName: "Rate app"),
            EthereTypeUell(imageName: "doc.text.fill", itemName: "Usage Policy")
        ]
        
        // Labels
        private let titleLabel = TroSimpleTroLabelRch(text: "Settings",
                                                      textColor: .white,
                                                    font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.mainFontSize))
        // CollectionView
        private let settingsCollView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collView.backgroundColor = .appMainBckgrd
            collView.layer.cornerRadius = 16
            collView.register(PrefRchsCellSor.self, forCellWithReuseIdentifier: "\(PrefRchsCellSor.self)")
            collView.showsHorizontalScrollIndicator = false
            collView.translatesAutoresizingMaskIntoConstraints = false
            return collView
        }()
        
        // LC
        override func viewDidLoad() {
            super.viewDidLoad()
            setView()
            contraints()
        }
    }

    private extension RchSetSorScrTop {
        func setView() {
            view.backgroundColor = .appMainBckgrd
            settingsCollView.dataSource = self
            settingsCollView.delegate = self
        }
        
        func contraints() {
            view.addSubview(titleLabel)
            view.addSubview(settingsCollView)
            NSLayoutConstraint.activate([
                
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                settingsCollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
                settingsCollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                settingsCollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                settingsCollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
            ])
        }
    }

    // User actions
    private extension RchSetSorScrTop {
        func rateUsDidTapped() {
            if #available(iOS 14.0, *),
               let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                DispatchQueue.main.async {
                    SKStoreReviewController.requestReview(in: scene)
                }
            } else {
                SKStoreReviewController.requestReview()
            }
        }
        func shareApp(indexPath: IndexPath) {
            if let shareAppLink = URL(string: "https://apps.apple.com/us/app/sports-merch/id6503341378") {
                let activityController = UIActivityViewController(activityItems: [shareAppLink], applicationActivities: nil)
                if UIDevice.current.userInterfaceIdiom == .pad,
                   let popoverController = activityController.popoverPresentationController {
                    let cell = settingsCollView.cellForItem(at: indexPath)
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell?.bounds ?? CGRect(x: 0, y: 0, width: 50, height: 50)
                }
                self.present(activityController, animated: true)
            }
        }
    }

    // CollectionView
    extension RchSetSorScrTop: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            preffers.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PrefRchsCellSor.self)", for: indexPath) as? PrefRchsCellSor else {
                return UICollectionViewCell()
            }
            let shiftPrefer = preffers[indexPath.row]
            cell.set(shiftPrefer)
            return cell
        }
    }

    extension RchSetSorScrTop: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            switch indexPath {
            case [0, 0]:
                shareApp(indexPath: indexPath)
            case [0, 1]:
                rateUsDidTapped()
            case [0, 2]:
                if let usagePolicyURL = URL(string: "https://www.termsfeed.com/live/41646307-20bc-4436-9a66-0ab271342752") {
                    let vc = RchUsageSorPolicyTopScreenTro(url: usagePolicyURL)
                    navigationController?.pushViewController(vc, animated: true)
                }
            default:
                break
            }
        }
    }

    extension RchSetSorScrTop: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width: Double = collectionView.frame.width * 0.9
            let height: Double = collectionView.frame.height / Double(4)
            return CGSize(width: width, height: height)
        }
    }
