

import Foundation

protocol ShopsErchProtocol: AnyObject {
    var updateShops: (() -> Void)? { get set }
    var shops: [Shop] { get set }
    
    func add(new shop: Shop)
    func delete(_ deletingShop: Shop)
    func update(oldShop: Shop, for newShop: Shop)
}

final class ShopsErchVm: ShopsErchProtocol {
    var updateShops: (() -> Void)?
    
    
    init(storage: RaceSaverAtsManagerSta<Shop>) {
        self.storage = storage
        getShops()
    }
    
    private let storage: RaceSaverAtsManagerSta<Shop>
    
    var shops: [Shop] = [] {
        didSet {
             updateShops?()
        }
    }
}

extension ShopsErchVm {
    func add(new shop: Shop) {
        let key = "UserShops"
        storage.saveModel(shop, key: key)
        
        getShops()
    }
    
    func update(oldShop: Shop, for newShop: Shop) {
        let key = "UserShops"
        var bufferShops = shops
        
        shops.enumerated().forEach({ index, value in
            if value == oldShop {
                bufferShops[index] = newShop
            }
        })
        storage.saveModels(bufferShops, key: key)
        
        getShops()
    }
    
    func delete(_ deletingShop: Shop) {
        let key = "UserShops"
        var bufferShops = shops
        
        shops.enumerated().forEach({ index, value in
            if value == deletingShop {
                bufferShops.remove(at: index)
            }
        })
        storage.saveModels(bufferShops, key: key)
        
        getShops()
    }
}

private extension ShopsErchVm {
    func getShops() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self else {
                return
            }
            
            let key = "UserShops"
            self.shops = self.storage.getModels(with: key)
        }
    }
}
