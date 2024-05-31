import UIKit

final class RchTabSorBarRSorModuleRop: UITabBarController {
    init(picker: SorPickerRemControllerSor = SorPickerRemControllerSor(),
         teamsStorage: RaceSaverAtsManagerSta<SorTeamRch> = RaceSaverAtsManagerSta<SorTeamRch>(),
         shopsStorage: RaceSaverAtsManagerSta<SorShopRchs> = RaceSaverAtsManagerSta<SorShopRchs>(),
         fileManagerService: FileManagerServiceProtocol = FileManagerService()) {
        self.picker = picker
        self.fileManagerService = fileManagerService
        self.teamStorage = teamsStorage
        self.shopStorage = shopsStorage
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var teamsEchContr = SportsRchTeamsSorContrlr(sportsTeamsVm: SportsSorTeamsVmRch(storage: teamStorage),
                                                            pickerContr: picker,
                                                            fileManager: fileManagerService)
    
    private lazy var shopsEachContr = TheSorShopsTopContrlrRch(shopsErchVm: ShopsTopErchVmRch(storage: shopStorage),
                                                         pickerContr: picker,
                                                         fileManager: fileManagerService)
    
    private let setEachContr = RchSetSorScrTop()
    
    private let picker: SorPickerRemControllerSor
    private let fileManagerService: FileManagerServiceProtocol
    private let teamStorage: RaceSaverAtsManagerSta<SorTeamRch>
    private let shopStorage: RaceSaverAtsManagerSta<SorShopRchs>
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        
        setTabBarAppearance()
    }
}

private extension RchTabSorBarRSorModuleRop {
    
    func setTabBarAppearance() {

        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.layer.cornerRadius = tabBar.frame.height / 2
        
        tabBar.tintColor = .appPrimaryColor
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white
    }
    
    func generateTabBar() {
        viewControllers = [
            create(vc: teamsEchContr,
                   title: "",
                   image: UIImage(systemName: "house.fill")),
            create(vc: shopsEachContr,
                   title: "",
                   image: UIImage(systemName: "doc.fill.badge.plus")),
            create(vc: setEachContr,
                   title: "",
                   image: UIImage(systemName: "gearshape.fill"))
        ]
    }
    
    func create(vc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
}
