

import Foundation

protocol ShopsErchProtocolSor: AnyObject {
    var updateShops: (() -> Void)? { get set }
    var shops: [Shop] { get set }
    
    func add(new shop: Shop)
    func delete(_ deletingShop: Shop)
    func update(oldShop: Shop, for newShop: Shop)
    
    func add(new brand: BrandName, with shopIndexPath: Int)
    func delete(_ deletingBrand: BrandName, with shopIndexPath: Int)
    func update(_ oldBrand: BrandName, with newBrand: BrandName, with shopIndexPath: Int)
}

final class ShopsTopErchVmRch: ShopsErchProtocolSor {
    
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

// Edit shops
extension ShopsTopErchVmRch {
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

// Edit brands
extension ShopsTopErchVmRch {
    
    func add(new brand: BrandName, with shopIndexPath: Int) {
        if shopIndexPath <= shops.count - 1 {
            let key = "UserShops"
            var bufferShops = shops
            let currentShop = bufferShops[shopIndexPath]
            
            var brands = currentShop.brandName
            brands.append(brand)
            
            let updatingShop = Shop(imageName: currentShop.imageName,
                                    shopName: currentShop.shopName,
                                    phoneNumber: currentShop.phoneNumber,
                                    brandName: brands,
                                    address: currentShop.address)
            
            bufferShops[shopIndexPath] = updatingShop
            
            storage.saveModels(bufferShops, key: key)
            
            getShops()
        }
    }
    
    func update(_ oldBrand: BrandName, with newBrand: BrandName, with shopIndexPath: Int) {
        if shopIndexPath <= shops.count - 1 {
            let key = "UserShops"
            var bufferShops = shops
            
            let shop = bufferShops[shopIndexPath]
            
            var bufferBrands = shop.brandName
            
            shop.brandName.enumerated().forEach { index, value in
                if value == oldBrand {
                    bufferBrands[index] = newBrand
                }
            }
            
            let updatingShop = Shop(imageName: shop.imageName,
                                    shopName: shop.shopName,
                                    phoneNumber: shop.phoneNumber,
                                    brandName: bufferBrands,
                                    address: shop.address)
            
            bufferShops[shopIndexPath] = updatingShop
            
            storage.saveModels(bufferShops, key: key)
            
            getShops()
        }
    }
    
    
    func delete(_ deletingBrand: BrandName, with shopIndexPath: Int) {
        if shopIndexPath <= shops.count - 1 {
            let key = "UserShops"
            var bufferShops = shops
            
            let shop = bufferShops[shopIndexPath]
            
            var bufferBrands = shop.brandName
            
            shop.brandName.enumerated().forEach { index, value in
                if value == deletingBrand {
                    bufferBrands.remove(at: index)
                }
            }
            
            let updatingShop = Shop(imageName: shop.imageName,
                                    shopName: shop.shopName,
                                    phoneNumber: shop.phoneNumber,
                                    brandName: bufferBrands,
                                    address: shop.address)
            
            bufferShops[shopIndexPath] = updatingShop
            
            storage.saveModels(bufferShops, key: key)
            
            getShops()
        }
    }
}

private extension ShopsTopErchVmRch {
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
