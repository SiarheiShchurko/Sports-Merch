struct Team: Codable {
    let imageName: String
    let teamName: String
    let phoneNumber: String
    let brandAttributes: [BrandAttributes]
}

extension Team: Equatable {
    static func ==(lhs: Team, rhs: Team) -> Bool {
        return lhs.imageName == rhs.imageName &&
        lhs.teamName == rhs.teamName &&
        lhs.phoneNumber == rhs.phoneNumber &&
        lhs.brandAttributes == rhs.brandAttributes
    }
}
