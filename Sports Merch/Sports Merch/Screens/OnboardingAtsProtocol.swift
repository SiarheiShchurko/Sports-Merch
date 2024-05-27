protocol OnboardingAtsProtocol: AnyObject {
    var array: [SecOnboardArtsTypeRace] { get }
}
final class OnboardingRaceViewAtsModel: OnboardingAtsProtocol {
    init(isView: Bool) {
        self.isView = isView
    }
    private let isView: Bool
    lazy var array: [SecOnboardArtsTypeRace] = {
        isView ? isViewArray : noViewArray
    }()
    
    private let noViewArray = [
        SecOnboardArtsTypeRace(imageName: "KeepRecordsOfStores",
                              mainText: "Keep records of stores",
                              secondaryText: ""),
        SecOnboardArtsTypeRace(imageName: "TheAppIsAlwaysAtHand",
                              mainText: "The app is always at hand",
                              secondaryText: "")
    ]
    private let isViewArray = [
        SecOnboardArtsTypeRace(imageName: "PlayAndWinWithUs",
                              mainText: "Play and win with us",
                              secondaryText: ""),
        SecOnboardArtsTypeRace(imageName: "RateOurAppInTheAppStore",
                              mainText: "Rate our app in the AppStore",
                              secondaryText: "")
    ]
}
