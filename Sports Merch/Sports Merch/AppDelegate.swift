import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
  //  private let component = MyDataClass.getMyData()
    private lazy var settingResult: Bool = false {
        didSet {
            RaceDefltsAtsServiceCes.isRaceValAts = settingResult
            isRekoGtvTim = setGtv(with: RaceDefltsAtsServiceCes.isGtvRams)
        }
    }
    
    private var isRekoGtvTim: Bool = false {
        didSet {
            setTimConfigureReko(with: isRekoGtvTim)
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        if UIScreen.main.isCaptured {
            RaceDefltsAtsServiceCes.isRaceValAts = false
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        RaceDefltsAtsServiceCes.staOptionsCesLaunchesEca = launchOptions
        UIDevice.current.userInterfaceIdiom == .phone ? (RaceDefltsAtsServiceCes.secUsrRaceDvcAts = .phone) : (RaceDefltsAtsServiceCes.secUsrRaceDvcAts = .other)
        
        setFontSizes()
        setAddPreferences()
        
        // MARK: - Delete
        setTimConfigureReko(with: false)
        
        return true
    }
}

private extension AppDelegate {
    func setTimConfigureReko(with isRekoGtvTim: Bool) {
        let rootVC = SplashSorScreenTopRch(isGtv: isRekoGtvTim, splashVm: SplashTopVmRchSor(shopsStorage: RaceSaverAtsManagerSta()))
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
    }
    
    func setFontSizes() {
        if RaceDefltsAtsServiceCes.secUsrRaceDvcAts != .phone {
            CGFloat.RaceFontArtSizeSec.mainFontSize = 34.00
            CGFloat.RaceFontArtSizeSec.midleFontSize = 26.00
            CGFloat.RaceFontArtSizeSec.secondFontSize = 17.00
        }
    }
    
    func setAddPreferences() {
//        if component.isVpn ||
//           component.isCharging ||
//           component.chargePercent == -100 ||
//           component.chargePercent == 100 {
//            settingResult = false
//        } else {
//            settingResult = true
//        }
    }
}
