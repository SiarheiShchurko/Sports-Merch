struct SorTeamRch: Codable {
    let imageName: String
    let teamName: String
    let phoneNumber: String
    let brandAttributes: [SorBrandTopAttributesRchs]
}

extension SorTeamRch: Equatable {
    static func ==(lhs: SorTeamRch, rhs: SorTeamRch) -> Bool {
        return lhs.imageName == rhs.imageName &&
               lhs.teamName == rhs.teamName &&
               lhs.phoneNumber == rhs.phoneNumber &&
               lhs.brandAttributes == rhs.brandAttributes
    }
}
