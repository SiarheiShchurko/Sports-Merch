import Foundation

protocol SportsRchTeamsSorProtocol: AnyObject {
    var teams: [SorTeamRch]  { get set }
    var searchingTeams: [SorTeamRch] { get set }
    var searchingText: String { get set }
    var updateTeams: (() -> Void)? { get set }
    
    func add(new team: SorTeamRch)
    func update(oldTeam: SorTeamRch, for newTeam: SorTeamRch)
    func delete(_ deletingTeam: SorTeamRch)
}

final class SportsSorTeamsVmRch: SportsRchTeamsSorProtocol {
    init(storage: RaceSaverAtsManagerSta<SorTeamRch>) {
        self.storage = storage
        getTeams()
    }
    
    private let storage: RaceSaverAtsManagerSta<SorTeamRch>
    
    var updateTeams: (() -> Void)?
    var teams: [SorTeamRch] = [] {
        didSet {
            updateTeams?()
        }
    }
    
     var searchingTeams: [SorTeamRch] = [] {
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
    func add(new team: SorTeamRch) {
        let key = "UserTeams"
        storage.saveModel(team, key: key)
        
        getTeams()
    }
    
    func update(oldTeam: SorTeamRch, for newTeam: SorTeamRch) {
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
    
    func delete(_ deletingTeam: SorTeamRch) {
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
