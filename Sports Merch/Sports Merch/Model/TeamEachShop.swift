struct TeamEachShop: Codable {
    let imageName: String
    let teamName: String
    let phoneNumber: String
    let brandAttributes: [BrandAttributes]
    let address: String?
}

extension TeamEachShop: Equatable {
    static func ==(lhs: TeamEachShop, rhs: TeamEachShop) -> Bool {
        return lhs.imageName == rhs.imageName &&
        lhs.teamName == rhs.teamName &&
        lhs.phoneNumber == rhs.phoneNumber &&
        lhs.brandAttributes == rhs.brandAttributes &&
        lhs.address == rhs.address
    }
}
