struct BrandAttributes: Codable {
    let brandName: String
    let count: Int?
}

extension BrandAttributes: Equatable {
    static func ==(lhs: BrandAttributes, rhs: BrandAttributes) -> Bool {
        return lhs.brandName == rhs.brandName &&
        lhs.count == rhs.count
    }
}
