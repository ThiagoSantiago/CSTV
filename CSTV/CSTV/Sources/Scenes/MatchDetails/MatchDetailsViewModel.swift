//
//  MatchDetailsViewModel.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation

struct MatchDetailsData {
    let beginTime: String
    let firstTeam: OpponentData
    let secondTeam: OpponentData
    let leagueName: String
    let serieName: String
}

protocol MatchDetailsViewModeling {
    var isLoading: Bindable<Bool> { get }
    var errorMessage: Bindable<String?> { get }
    var matchData: Bindable<MatchDetailsData?> { get }
    var teams: Bindable<[TeamDetailsData]> { get }
    func fetch()
}

final class MatchDetailsViewModel: MatchDetailsViewModeling {
    var isLoading: Bindable<Bool> = .init(false)
    var errorMessage: Bindable<String?> = .init(nil)
    var teams: Bindable<[TeamDetailsData]> = .init([])
    var matchData: Bindable<MatchDetailsData?> = .init(nil)
    var repository: MatchDetailsRepository
    
    
    init(repository: MatchDetailsRepository, matchData: MatchDetailsData) {
        self.repository = repository
        self.matchData.value = matchData
    }
    
    func fetch() {
        isLoading.value = true
        repository.fetchTeamsDetails(firstTeamId: matchData.value?.firstTeam.id ?? 0,
                                     secondTeamId: matchData.value?.secondTeam.id ?? 0,
                                     completion: { [weak self] result in
            
            guard let self = self else { return }
            self.isLoading.value = false
            
            switch result {
            case let .success(teams):
                self.teams.value = teams
            case let .failure(error):
                self.errorMessage.value = error.localizedDescription
            }
        })
    }
}
