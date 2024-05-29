struct BrandName: Codable {
    let brandName: String
    let brandAttributes: [BrandAttributes]
}

extension BrandName: Equatable {
    static func ==(lhs: BrandName, rhs: BrandName) -> Bool {
        return lhs.brandName == rhs.brandName &&
               lhs.brandAttributes == rhs.brandAttributes
    }
}
