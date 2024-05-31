struct SorBrandTopAttributesRchs: Codable {
    let brandName: String
    let count: Int?
}

extension SorBrandTopAttributesRchs: Equatable {
    static func ==(lhs: SorBrandTopAttributesRchs, rhs: SorBrandTopAttributesRchs) -> Bool {
        return lhs.brandName == rhs.brandName &&
        lhs.count == rhs.count
    }
}
