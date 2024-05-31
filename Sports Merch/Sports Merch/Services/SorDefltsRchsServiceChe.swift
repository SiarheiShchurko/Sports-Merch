import UIKit

enum SorDefltsRchsServiceChe {
    static var remOptionsRchsLaunchesChe: [UIApplication.LaunchOptionsKey: Any]? {
        get { UserDefaults.standard.value(forKey: "remOptionsRchsLaunchesChe") as? [UIApplication.LaunchOptionsKey: Any] }
        set { UserDefaults.standard.setValue(newValue, forKey: "remOptionsRchsLaunchesChe") }
    }
    static var isRchsValChe: Bool {
        get { UserDefaults.standard.value(forKey: "isRchsValChe") as? Bool ?? false }
        set { UserDefaults.standard.setValue(newValue, forKey: "isRchsValChe") }
    }
    static var isRemGtvChe: String {
        get { UserDefaults.standard.value(forKey: "isRemGtvChe") as? String ?? "30.06.2024" }
        set { UserDefaults.standard.setValue(newValue, forKey: "isRemGtvChe") }
    }
    static var rchsKnilChe: String {
        get { UserDefaults.standard.value(forKey: "rchsKnilChe") as? String ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: "rchsKnilChe") }
    }
    static var remObitationChe: String {
        get { UserDefaults.standard.value(forKey: "remObitationChe") as? String ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: "remObitationChe") }
    }
    static var remAppHudRchsUserIdChe: String {
        get { UserDefaults.standard.value(forKey: "remAppHudRchsUserIdChe") as? String ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: "remAppHudRchsUserIdChe") }
    }
    static var isRemOnboardingRchsDidShowedChe: Bool {
        get { UserDefaults.standard.value(forKey: "isRemOnboardingRchsDidShowedChe") as? Bool ?? false }
        set { UserDefaults.standard.setValue(newValue, forKey: "isRemOnboardingRchsDidShowedChe") }
    }

    static var remUsrRchsDvcChe: RchsUsrTopDeviceSor {
        get {
            guard let userDevice = UserDefaults.standard.data(forKey: "remUsrRchsDvcChe") else {
                return
                    .phone
            }
            return (try? JSONDecoder().decode(RchsUsrTopDeviceSor.self, from: userDevice)) ?? .phone
        }
        set {
            if let newUserDevice = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(newUserDevice, forKey: "remUsrRchsDvcChe")
            }
        }
    }
}

