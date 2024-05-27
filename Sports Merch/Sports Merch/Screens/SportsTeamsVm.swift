protocol SportsTeamsProtocol: AnyObject {
    var updateTeams: (() -> Void)? { get set }
    var teams: [Team] = { get set }
}

final class SportsTeamsVm: SportsTeamsProtocol {
    var updateTeams: (() -> Void)?
    var teams: [Team] = [] {
        didSet {
            updateTeams
        }
    }
}
