protocol OnboardingTopProtocolRchSor: AnyObject {
    var array: [ModOnboardTorTypeSor] { get }
}
final class OnboardingRchViewTopModel: OnboardingTopProtocolRchSor {
    init(isView: Bool) {
        self.isView = isView
    }
    private let isView: Bool
    lazy var array: [ModOnboardTorTypeSor] = {
        isView ? isViewArray : noViewArray
    }()
    
    private let noViewArray = [
        ModOnboardTorTypeSor(imageName: "KeepRecordsOfStores",
                              mainText: "Keep records of stores",
                              secondaryText: ""),
        ModOnboardTorTypeSor(imageName: "TheAppIsAlwaysAtHand",
                              mainText: "The app is always at hand",
                              secondaryText: "")
    ]
    private let isViewArray = [
        ModOnboardTorTypeSor(imageName: "PlayAndWinWithUs",
                              mainText: "Play and win with us",
                              secondaryText: ""),
        ModOnboardTorTypeSor(imageName: "RateOurAppInTheAppStore",
                              mainText: "Rate our app in the AppStore",
                              secondaryText: "")
    ]
}
