import Foundation

protocol SportsTeamsProtocol: AnyObject {
    var teams: [TeamEachShop]  { get set }
    var searchingTeams: [TeamEachShop] { get set }
    var searchingText: String { get set }
    var updateTeams: (() -> Void)? { get set }
    
    func add(new team: TeamEachShop)
    func update(oldTeam: TeamEachShop, for newTeam: TeamEachShop)
    func delete(_ deletingTeam: TeamEachShop)
}

final class SportsTeamsVm: SportsTeamsProtocol {
    init(storage: RaceSaverAtsManagerSta<TeamEachShop>) {
        self.storage = storage
        getTeams()
    }
    
    private let storage: RaceSaverAtsManagerSta<TeamEachShop>
    
    var updateTeams: (() -> Void)?
    var teams: [TeamEachShop] = [] {
        didSet {
            updateTeams?()
        }
    }
    
     var searchingTeams: [TeamEachShop] = [] {
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

extension SportsTeamsVm {
    func add(new team: TeamEachShop) {
        let key = "UserTeams"
        storage.saveModel(team, key: key)
        
        getTeams()
    }
    
    func update(oldTeam: TeamEachShop, for newTeam: TeamEachShop) {
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
    
    func delete(_ deletingTeam: TeamEachShop) {
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
