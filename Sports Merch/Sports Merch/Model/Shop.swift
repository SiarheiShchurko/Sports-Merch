struct Shop: Codable {
    let imageName: String
    let teamName: String
    let phoneNumber: String
    let brandName: [BrandName]
    let address: String
}

extension Shop: Equatable {
    static func ==(lhs: Shop, rhs: Shop) -> Bool {
        return lhs.imageName == rhs.imageName &&
        lhs.teamName == rhs.teamName &&
        lhs.phoneNumber == rhs.phoneNumber &&
        lhs.brandName == rhs.brandName &&
        lhs.address == rhs.address
    }
}
