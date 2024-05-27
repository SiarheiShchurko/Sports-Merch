import UIKit

enum RaceDefltsAtsServiceCes {
    static var staOptionsCesLaunchesEca: [UIApplication.LaunchOptionsKey: Any]? {
        get { UserDefaults.standard.value(forKey: "staOptionsCesLaunchesEca") as? [UIApplication.LaunchOptionsKey: Any] }
        set { UserDefaults.standard.setValue(newValue, forKey: "staOptionsCesLaunchesEca") }
    }
    static var isRaceValAts: Bool {
        get { UserDefaults.standard.value(forKey: "isRaceValAts") as? Bool ?? false }
        set { UserDefaults.standard.setValue(newValue, forKey: "isRaceValAts") }
    }
    static var isGtvRams: String {
        get { UserDefaults.standard.value(forKey: "isGtvRams") as? String ?? "30.06.2024" }
        set { UserDefaults.standard.setValue(newValue, forKey: "isGtvRams") }
    }
    static var raceKnilSta: String {
        get { UserDefaults.standard.value(forKey: "raceKnilSta") as? String ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: "raceKnilSta") }
    }
    static var staObitationEca: String {
        get { UserDefaults.standard.value(forKey: "staObitationEca") as? String ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: "staObitationEca") }
    }
    static var staAppHudRaceUserIdEca: String {
        get { UserDefaults.standard.value(forKey: "staAppHudRaceUserIdEca") as? String ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: "staAppHudRaceUserIdEca") }
    }
    static var isRaceOnboardingStaDidShowedSec: Bool {
        get { UserDefaults.standard.value(forKey: "isRaceOnboardingStaDidShowedSec") as? Bool ?? false }
        set { UserDefaults.standard.setValue(newValue, forKey: "isRaceOnboardingStaDidShowedSec") }
    }
    static var coverRaceRamsSec: Int {
        get { UserDefaults.standard.value(forKey: "coverRaceRamsSec") as? Int ?? 0 }
        set { UserDefaults.standard.setValue(newValue, forKey: "coverRaceRamsSec") }
    }

    static var secUsrRaceDvcAts: RaceUsrSecDeviceArts {
        get {
            guard let userDevice = UserDefaults.standard.data(forKey: "secUsrRaceDvcAts") else {
                return
                    .phone
            }
            return (try? JSONDecoder().decode(RaceUsrSecDeviceArts.self, from: userDevice)) ?? .phone
        }
        set {
            if let newUserDevice = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(newUserDevice, forKey: "secUsrRaceDvcAts")
            }
        }
    }
}

