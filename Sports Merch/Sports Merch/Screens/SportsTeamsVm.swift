import Foundation

protocol SportsTeamsProtocol: AnyObject {
    var teams: [Team]  { get set }
    var searchingText: String { get set }
    var updateTeams: (() -> Void)? { get set }
}

final class SportsTeamsVm: SportsTeamsProtocol {
    init(storage: RaceSaverAtsManagerSta<Team>) {
        self.storage = storage
    }
    
    private let storage: RaceSaverAtsManagerSta<Team>
    
    var updateTeams: (() -> Void)?
    var teams: [Team] = [] {
        didSet {
            updateTeams?()
        }
    }
    
    private var searchingTeams: [Team] = [] {
        didSet {
            updateTeams?()
        }
    }
    
    var searchingText: String = "" {
        didSet {
            searchTeam(with: searchingText)
        }
    }
}

private extension SportsTeamsVm {
    func getTeams() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self else {
                return
            }
            
            let key = "UserTeams"
            self.teams = self.storage.getModels(with: key)
        }
    }
    
    func searchTeam(with name: String) {
        searchingTeams = teams.filter({$0.teamName.lowercased().contains(name.lowercased() ) == .some(true) })
    }
}

private extension SportsTeamsVm {
    
}
