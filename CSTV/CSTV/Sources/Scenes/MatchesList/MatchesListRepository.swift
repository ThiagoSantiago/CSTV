//
//  MatchesListRepository.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation

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
                  let firstOponent: Opponent = item.opponents?[0].opponent,
                  let seconfOponent: Opponent = item.opponents?[1].opponent,
                  let games: [Game] = item.games,
                  let gameNotCompleted = games.filter({ $0.complete == false }).first else { return }
            
            let match = MatchData(firstOponentName: firstOponent.name ?? "",
                             firstOponentLogo: firstOponent.imageUrl ?? "",
                             secondOponentName: seconfOponent.name ?? "",
                             secondOponentLogo: seconfOponent.imageUrl ?? "",
                             beginTime: item.beginAt ?? "",
                             endTime: item.endAt ?? "",
                             gameStatus: gameNotCompleted.status ?? "",
                             leagueImage: item.league?.imageUrl ?? "",
                             leagueName: item.league?.name ?? "",
                             serieName: item.serie?.name ?? "")
            matchesData.append(match)
        }
        
        return matchesData
    }
}
