

import Foundation

protocol ShopsErchProtocol: AnyObject {
    var shops: [Shop] { get set }
}

final class ShopsErchVm: ShopsErchProtocol {
    var shops: [Shop] = [
    Shop(imageName: "",
         teamName: "Test1",
         phoneNumber: "43548345",
         brandName: [BrandName(brandName: "AAA", brandAttributes: [BrandAttributes(brandName: "AAA", count: 21)])],
         address: "Asdasdadasd"),
    Shop(imageName: "",
         teamName: "Test1",
         phoneNumber: "43548345",
         brandName: [BrandName(brandName: "AAA", brandAttributes: [BrandAttributes(brandName: "AAA", count: 21)])],
         address: "Asdasdadasd"),
    Shop(imageName: "",
         teamName: "Test1",
         phoneNumber: "43548345",
         brandName: [BrandName(brandName: "AAA", brandAttributes: [BrandAttributes(brandName: "AAA", count: 21)])],
         address: "Asdasdadasd")
    
    ] {
        didSet {
            
        }
    }
}
