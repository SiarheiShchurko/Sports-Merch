import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
  //  private let component = MyDataClass.getMyData()
    private lazy var settingResult: Bool = false {
        didSet {
            SorDefltsRchsServiceChe.isRchsValChe = settingResult
            isRekoGtvTim = setGtv(with: SorDefltsRchsServiceChe.isRemGtvChe)
        }
    }
    
    private var isRekoGtvTim: Bool = false {
        didSet {
            setTimConfigureReko(with: isRekoGtvTim)
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        if UIScreen.main.isCaptured {
            SorDefltsRchsServiceChe.isRchsValChe = false
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SorDefltsRchsServiceChe.remOptionsRchsLaunchesChe = launchOptions
        UIDevice.current.userInterfaceIdiom == .phone ? (SorDefltsRchsServiceChe.remUsrRchsDvcChe = .phone) : (SorDefltsRchsServiceChe.remUsrRchsDvcChe = .other)
        
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
        if SorDefltsRchsServiceChe.remUsrRchsDvcChe != .phone {
            CGFloat.RchsFontSorSizeTro.mainFontSize = 34.00
            CGFloat.RchsFontSorSizeTro.midleFontSize = 26.00
            CGFloat.RchsFontSorSizeTro.secondFontSize = 17.00
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
