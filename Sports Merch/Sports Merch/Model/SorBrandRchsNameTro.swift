struct SorBrandRchsNameTro: Codable {
    let brandName: String
    let brandAttributes: [SorBrandTopAttributesRchs]
}

extension SorBrandRchsNameTro: Equatable {
    static func ==(lhs: SorBrandRchsNameTro, rhs: SorBrandRchsNameTro) -> Bool {
        return lhs.brandName == rhs.brandName &&
               lhs.brandAttributes == rhs.brandAttributes
    }
}
