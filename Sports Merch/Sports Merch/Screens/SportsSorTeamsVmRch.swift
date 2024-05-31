import Foundation

protocol SportsRchTeamsSorProtocol: AnyObject {
    var teams: [Team]  { get set }
    var searchingTeams: [Team] { get set }
    var searchingText: String { get set }
    var updateTeams: (() -> Void)? { get set }
    
    func add(new team: Team)
    func update(oldTeam: Team, for newTeam: Team)
    func delete(_ deletingTeam: Team)
}

final class SportsSorTeamsVmRch: SportsRchTeamsSorProtocol {
    init(storage: RaceSaverAtsManagerSta<Team>) {
        self.storage = storage
        getTeams()
    }
    
    private let storage: RaceSaverAtsManagerSta<Team>
    
    var updateTeams: (() -> Void)?
    var teams: [Team] = [] {
        didSet {
            updateTeams?()
        }
    }
    
     var searchingTeams: [Team] = [] {
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

private extension SportsSorTeamsVmRch {
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

extension SportsSorTeamsVmRch {
    func add(new team: Team) {
        let key = "UserTeams"
        storage.saveModel(team, key: key)
        
        getTeams()
    }
    
    func update(oldTeam: Team, for newTeam: Team) {
        let key = "UserTeams"
        var bufferTeams = teams
        
        teams.enumerated().forEach({ index, value in
            if value == oldTeam {
                bufferTeams[index] = newTeam
            }
        })
        storage.saveModels(bufferTeams, key: key)
        
        getTeams()
    }
    
    func delete(_ deletingTeam: Team) {
        let key = "UserTeams"
        var bufferTeams = teams
        
        teams.enumerated().forEach({ index, value in
            if value == deletingTeam {
                bufferTeams.remove(at: index)
            }
        })
        storage.saveModels(bufferTeams, key: key)
        
        getTeams()
    }
}
