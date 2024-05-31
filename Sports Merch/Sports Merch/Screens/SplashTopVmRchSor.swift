import UIKit

protocol SplashTopVmProtocolSor: AnyObject {
    
}

final class SplashTopVmRchSor: SplashTopVmProtocolSor {
    init(shopsStorage: RaceSaverAtsManagerSta<SorShopRchs> = RaceSaverAtsManagerSta<SorShopRchs>()) {
        self.shopsStorage = shopsStorage
        getShops()
    }
    
    private let shopsStorage: RaceSaverAtsManagerSta<SorShopRchs>
    
    func getShops() {
        let key = "UserShops"
       if shopsStorage.getModels(with: key).isEmpty,
          !SorDefltsRchsServiceChe.isRemOnboardingRchsDidShowedChe {
           
           let defaultShop = SorShopRchs(imageName: "defaultShopImg",
                                  shopName: "SportShop",
                                  phoneNumber: "+502 502 22 28 65 86",
                                  brandName: [
                                  SorBrandRchsNameTro(brandName: "American moose",
                                            brandAttributes: [
                                            SorBrandTopAttributesRchs(brandName: "T-shirts",
                                                            count: 54),
                                            SorBrandTopAttributesRchs(brandName: "Mugs",
                                                            count: 10),
                                            SorBrandTopAttributesRchs(brandName: "Balls",
                                                            count: 10)
                                            ]),
                                  SorBrandRchsNameTro(brandName: "The Black Dragon",
                                            brandAttributes: [
                                            SorBrandTopAttributesRchs(brandName: "T-shirts",
                                                            count: 2)
                                            ])
                                  ],
                                  address: "Metro Region, Guatemala, Sanaa 14, 20 Calle, 25-96")
           
           shopsStorage.saveModel(defaultShop, key: key)
       }
    }
}
