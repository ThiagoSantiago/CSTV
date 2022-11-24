//
//  MatchesListRepository.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation

enum GameStatus: String {
    case finished = "finished"
    case notPlayed = "not_played"
    case notStarted = "not_started"
    case running = "running"
}

struct OpponentData {
    let id: Int
    let name: String
    let imageUrl: String
}

struct MatchData {
    let firstOponent: OpponentData
    let secondOponent: OpponentData
    let beginTime: String
    let endTime: String
    let gameStatus: String
    let leagueImage: String
    let leagueName: String
    let serieName: String
}

protocol MatchesListRepositoryType {
    func fetchMatchesList(pageIndex: Int, completion: @escaping (Swift.Result<[MatchData], CSTVApiError>) -> Void)
}

final class MatchesListRepository: MatchesListRepositoryType {
    let requester: CSTVApiRequestProtocol
    private var allMatches: [Match] = []
    
    init(requester: CSTVApiRequestProtocol = CSTVApiRequest()) {
        self.requester = requester
    }
    
    func fetchMatchesList(pageIndex: Int, completion: @escaping (Swift.Result<[MatchData], CSTVApiError>) -> Void) {
        requester.request(with: MatchesListServiceSetup.getMatches(page: pageIndex)) { [weak self] (result: Swift.Result<[Match], CSTVApiError>) in
            guard let self = self else {
                completion(.failure(CSTVApiError.unknown("Error parsing the data.")))
                return }
            
            switch result {
            case let .success(matches):
                self.allMatches.append(contentsOf: matches)
                let matceshData = self.parseMatches(matches: self.allMatches)
                completion(.success(matceshData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseMatches(matches: [Match]) -> [MatchData] {
        var matchesData: [MatchData] = []
        
        matches.forEach { item in
            guard let oponentsCount = item.opponents?.count,
                  oponentsCount == 2,
                  let firstOpponent: Opponent = item.opponents?[0].opponent,
                  let seconfOpponent: Opponent = item.opponents?[1].opponent else { return }
            
            let firstOpponentData = OpponentData(id: firstOpponent.id ?? 0,
                                                name: firstOpponent.name ?? "",
                                                imageUrl: firstOpponent.imageUrl ?? "")
            
            let secondOpponentData = OpponentData(id: seconfOpponent.id ?? 0,
                                                name: seconfOpponent.name ?? "",
                                                imageUrl: seconfOpponent.imageUrl ?? "")
            
            let match = MatchData(firstOponent: firstOpponentData,
                             secondOponent: secondOpponentData,
                             beginTime: item.beginAt ?? "",
                             endTime: item.endAt ?? "",
                             gameStatus: item.status ?? "",
                             leagueImage: item.league?.imageUrl ?? "",
                             leagueName: item.league?.name ?? "",
                             serieName: item.serie?.name ?? "")
            
            matchesData.append(match)
        }
        
        return matchesData
    }
}
