import UIKit

protocol SplashVmProtocol: AnyObject {
    
}

final class SplashVm: SplashVmProtocol {
    init(shopsStorage: RaceSaverAtsManagerSta<Shop> = RaceSaverAtsManagerSta<Shop>()) {
        self.shopsStorage = shopsStorage
        getShops()
    }
    
    private let shopsStorage: RaceSaverAtsManagerSta<Shop>
    
    func getShops() {
        let key = "UserShops"
       if shopsStorage.getModels(with: key).isEmpty,
          !RaceDefltsAtsServiceCes.isRaceOnboardingStaDidShowedSec {
           
           let defaultShop = Shop(imageName: "defaultShopImg",
                                  shopName: "SportShop",
                                  phoneNumber: "+502 502 22 28 65 86",
                                  brandName: [
                                  BrandName(brandName: "American moose",
                                            brandAttributes: [
                                            BrandAttributes(brandName: "T-shirts",
                                                            count: 54),
                                            BrandAttributes(brandName: "Mugs",
                                                            count: 10),
                                            BrandAttributes(brandName: "Balls",
                                                            count: 10)
                                            ]),
                                  BrandName(brandName: "The Black Dragon",
                                            brandAttributes: [
                                            BrandAttributes(brandName: "T-shirts",
                                                            count: 2)
                                            ])
                                  ],
                                  address: "Metro Region, Guatemala, Sanaa 14, 20 Calle, 25-96")
           
           shopsStorage.saveModel(defaultShop, key: key)
       }
    }
}
