import UIKit

final class TabBarRaceModuleSec: UITabBarController {
    init(picker: RacePickerController = RacePickerController(),
         teamsStorage: RaceSaverAtsManagerSta<Team> = RaceSaverAtsManagerSta<Team>(),
         shopsStorage: RaceSaverAtsManagerSta<Shop> = RaceSaverAtsManagerSta<Shop>(),
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
    
    private lazy var teamsEchContr = SportsTeamsContrlr(sportsTeamsVm: SportsTeamsVm(storage: teamStorage),
                                                            pickerContr: picker,
                                                            fileManager: fileManagerService)
    
    private lazy var shopsEachContr = TheShopsContrlr(shopsErchVm: ShopsErchVm(storage: shopStorage),
                                                         pickerContr: picker,
                                                         fileManager: fileManagerService)
    
    private let setEachContr = RaceSettingsArtModule()
    
    private let picker: RacePickerController
    private let fileManagerService: FileManagerServiceProtocol
    private let teamStorage: RaceSaverAtsManagerSta<Team>
    private let shopStorage: RaceSaverAtsManagerSta<Shop>
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        
        setTabBarAppearance()
    }
}

private extension TabBarRaceModuleSec {
    
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
