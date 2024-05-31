struct SorShopRchs: Codable {
    let imageName: String
    let shopName: String
    let phoneNumber: String
    let brandName: [SorBrandRchsNameTro]
    let address: String
}

extension SorShopRchs: Equatable {
    static func ==(lhs: SorShopRchs, rhs: SorShopRchs) -> Bool {
        return lhs.imageName == rhs.imageName &&
        lhs.shopName == rhs.shopName &&
        lhs.phoneNumber == rhs.phoneNumber &&
        lhs.brandName == rhs.brandName &&
        lhs.address == rhs.address
    }
}
