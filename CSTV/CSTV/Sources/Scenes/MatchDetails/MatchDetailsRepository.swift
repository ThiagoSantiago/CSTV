//
//  MatchDetailsRepository.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation

struct TeamDetailsData {
    let teamId: Int
    let players: [PlayerData]
}

struct PlayerData {
    let playerId: Int
    let firstName: String
    let imageURL: String
    let lastName: String
    let name: String
}

protocol MatchDetailsRepositoryType {
    func fetchTeamsDetails(firstTeamId: Int, secondTeamId: Int, completion: @escaping (Swift.Result<[TeamDetailsData], CSTVApiError>) -> Void)
}

final class MatchDetailsRepository: MatchDetailsRepositoryType {
    
    let requester: CSTVApiRequestProtocol
    private var allMatches: [Match] = []
    
    init(requester: CSTVApiRequestProtocol = CSTVApiRequest()) {
        self.requester = requester
    }
    
    func fetchTeamsDetails(firstTeamId: Int, secondTeamId: Int, completion: @escaping (Swift.Result<[TeamDetailsData], CSTVApiError>) -> Void) {
        requester.request(with: MatchDetailsServiceSetup.getTeamsDetails(firstOpponentId: firstTeamId, secondOpponentId: secondTeamId)) { [weak self] (result: Swift.Result<[TeamDetails], CSTVApiError>) in
            guard let self = self else {
                completion(.failure(CSTVApiError.unknown("Error parsing the data.")))
                return }
            
            switch result {
            case let .success(teams):
                completion(.success(self.parseTeams(teams: teams)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseTeams(teams: [TeamDetails]) -> [TeamDetailsData] {
        return teams.compactMap { team in

            let players: [PlayerData] = team.players.compactMap { player in
                PlayerData(playerId: player.id,
                           firstName: player.firstName ?? "",
                           imageURL: player.imageUrl ?? "",
                           lastName: player.lastName ?? "",
                           name: player.name)
            }

            return TeamDetailsData(teamId: team.id,
                                   players: players)
        }
    }
}
