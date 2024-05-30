import UIKit

final class TheShopsContrlr: UIViewController {
    init(shopsErchVm: ShopsErchProtocol,
         pickerContr: RacePickerController,
         fileManager: FileManagerServiceProtocol) {
        self.shopsErchVm = shopsErchVm
        self.picker = pickerContr
        self.fileManagerService = fileManager
        super.init(nibName: nil,
                   bundle: nil)
        updateErchShops()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Prprts
    private var isSearching: Bool = false
    private let picker: RacePickerController
    private let shopsErchVm: ShopsErchProtocol
    private let fileManagerService: FileManagerServiceProtocol
    
    private var shopIndexPath: Int?
    
    // Labels
    private let headerLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "The shops",
                                                                     textColor: .white,
                                                                     font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.mainFontSize))
    
    private let emptyLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "\nAdd your first store",
                                                                    textColor: .black,
                                                                    font: .boldSystemFont(ofSize: CGFloat.RaceFontArtSizeSec.midleFontSize),
                                                                    textAlignment: .center)
    
    private let bottomEmptyLabel: SecSimpleLabelRace = SecSimpleLabelRace(text: "")
    
    // Image
    private let emptyTeamsImage = SecUnicalImageRaceViewAts(imageName: "emptyTeamImg",
                                                            comtentMode: .scaleAspectFit)
    // Buttons
    private let plusShopsErchButton: SimpleSecImageRaceButtonAts = SimpleSecImageRaceButtonAts(isSystem: true,
                                                                                               imgName: "plus",
                                                                                               color: .white)
    private let addStackEachButton = ClasPrimarySecButtonRace(title: "Add")
    
    // CollectionView
    private let shopsCollectionView = SecTimCollectionRaceViewAts(cellClass: ShopsCellRch.self,
                                                                  id: "\(ShopsCellRch.self)",
                                                                  backgroudClr: .appMainBckgrd,
                                                                  scrollDirection: .horizontal)
    
    // Stacks
    private lazy var emptyStack = SecUniqueStackViewGniff(views: [emptyLabel, emptyTeamsImage, addStackEachButton, bottomEmptyLabel],
                                                          axis: .vertical,
                                                          alignment: .center,
                                                          distribution: .fillProportionally,
                                                          spacing: 16,
                                                          backgroundColor: .white,
                                                          cornerRadius: 16)
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setShopsErchController()
        shopTargets()
        setShopsErchConstraints()
    }
}


private extension TheShopsContrlr {
    func updateErchShops() {
        shopsErchVm.updateShops = { [ weak self ] in
            DispatchQueue.main.async {
                guard let self else {
                    return
                }
                self.shopsCollectionView.reloadData()
                self.emptyStack.isHidden = !self.shopsErchVm.shops.isEmpty
            }
        }
    }
}

private extension TheShopsContrlr {
    func setShopsErchController() {
        view.backgroundColor = .appMainBckgrd
        
        shopsCollectionView.dataSource = self
        shopsCollectionView.delegate = self
        
        emptyStack.isHidden = !shopsErchVm.shops.isEmpty
        
        shopsCollectionView.isUserInteractionEnabled = true
    }
    
    func setShopsErchConstraints() {
        view.addSubview(headerLabel)
        view.addSubview(plusShopsErchButton)
        view.addSubview(shopsCollectionView)
        view.addSubview(emptyStack)
        NSLayoutConstraint.activate([
            plusShopsErchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plusShopsErchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            plusShopsErchButton.widthAnchor.constraint(equalToConstant: 32),
            plusShopsErchButton.heightAnchor.constraint(equalToConstant: 32),
            
            headerLabel.bottomAnchor.constraint(equalTo: plusShopsErchButton.bottomAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            shopsCollectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            shopsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shopsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shopsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStack.centerYAnchor.constraint(equalTo: shopsCollectionView.centerYAnchor),
            emptyStack.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            emptyStack.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            
            addStackEachButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            addStackEachButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
    }
}

// Targets
private extension TheShopsContrlr {
    func shopTargets() {
        plusShopsErchButton.addTarget(self, action: #selector(plusShopDidTapped), for: .touchUpInside)
        addStackEachButton.addTarget(self, action: #selector(plusShopDidTapped), for: .touchUpInside)
    }
}

// User actions
private extension TheShopsContrlr {
    @objc func plusShopDidTapped() {
        let newShopScreen = NewShopScreen(newShopmVm: NewShopVm(fileManager: fileManagerService),
                                          currentShop: nil,
                                          picker: picker)
        newShopScreen.sportsShopDelegate = self
        navigationController?.pushViewController(newShopScreen, animated: true)
    }
}

extension TheShopsContrlr: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopsErchVm.shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ShopsCellRch.self)", for: indexPath) as? ShopsCellRch else {
            return UICollectionViewCell()
        }
        let shop: Shop = shopsErchVm.shops[indexPath.row]
        cell.editShopDelegate = self
        cell.set(shop, indexPath: indexPath.row)
        return cell
    }
}

extension TheShopsContrlr: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width * 0.95
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}

extension TheShopsContrlr: TransitObjectsDelegateProtocol {
    func add<T>(new: T) where T : Decodable, T : Encodable {
        if let newShop = new as? Shop {
            shopsErchVm.add(new: newShop)
        } else if let newBrand = new as? BrandName,
                  let shopIndexPath {
            shopsErchVm.add(new: newBrand, with: shopIndexPath)
        }
    }
    
    func delete<T>(_ deletingItem: T) where T : Decodable, T : Encodable {
        if let deletingShop = deletingItem as? Shop {
            shopsErchVm.delete(deletingShop)
        } else if let deletingBrand = deletingItem as? BrandName,
                  let shopIndexPath {
            shopsErchVm.delete(deletingBrand, with: shopIndexPath)
        }
    }
    
    func update<T>(oldValue: T, for newValue: T) where T : Decodable, T : Encodable {
        if let oldShop = oldValue as? Shop,
           let newShop = newValue as? Shop {
            shopsErchVm.update(oldShop: oldShop, for: newShop)
        } else if let oldBrand = oldValue as? BrandName,
                  let newBrand = newValue as? BrandName,
                  let shopIndexPath {
            shopsErchVm.update(oldBrand, with: newBrand, with: shopIndexPath)
        }
    }
}

extension TheShopsContrlr: EditShopDelegateProtocol {
    func edit(_ currentBrand: BrandName, with indexPath: Int) {
        shopIndexPath = indexPath
        
        let editBrandVc = NewBrandVc(currentBrand: currentBrand,
                                     newBrandVm: NewBrandVm())
        editBrandVc.sportsShopDelegate = self
        openRamsSheetsArt(vc: editBrandVc)
    }
    
    func openNewBrandVc(with indexPath: Int) {
        shopIndexPath = indexPath
        
        let newBrandVc = NewBrandVc(currentBrand: nil,
                                    newBrandVm: NewBrandVm())
        newBrandVc.sportsShopDelegate = self
        openRamsSheetsArt(vc: newBrandVc)
    }
    
    func openShopForEdit(with indexPath: Int) {
        let currentShop: Shop = shopsErchVm.shops[indexPath]
        
        let editShopScreen = NewShopScreen(newShopmVm: NewShopVm(fileManager: fileManagerService),
                                           currentShop: currentShop,
                                           picker: picker)
        editShopScreen.sportsShopDelegate = self
        navigationController?.pushViewController(editShopScreen, animated: true)
        
    }
}
