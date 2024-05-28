import UIKit

final class TabBarRaceModuleSec: UITabBarController {
    init(picker: RacePickerController = RacePickerController(),
         fileManagerService: FileManagerServiceProtocol = FileManagerService()) {
        self.picker = picker
        self.fileManagerService = fileManagerService
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var competitionsContr = SportsTeamsContrlr(sportsTeamsVm: SportsTeamsVm(storage: RaceSaverAtsManagerSta()),
                                                            pickerContr: picker, 
                                                            fileManager: fileManagerService)
    
    private lazy var participantsContr = TheShopsContrlr()
    
    private let picker: RacePickerController
    private let setContr = RaceSettingsArtModule()
    private let fileManagerService: FileManagerServiceProtocol
    
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
            create(vc: competitionsContr,
                   title: "",
                   image: UIImage(systemName: "house.fill")),
            create(vc: participantsContr,
                   title: "",
                   image: UIImage(systemName: "doc.fill.badge.plus")),
            create(vc: setContr,
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
