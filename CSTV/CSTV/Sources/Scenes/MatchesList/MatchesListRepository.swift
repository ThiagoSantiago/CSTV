//
//  MatchesListRepository.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation

protocol MatchesListRepositoryType {
    func fetchMatchesList(pageIndex: Int, completion: @escaping (Swift.Result<[Match], CSTVApiError>) -> Void)
}


final class MatchesListRepository: MatchesListRepositoryType {
    let requester: CSTVApiRequestProtocol
    
    init(requester: CSTVApiRequestProtocol = CSTVApiRequest()) {
            self.requester = requester
    }
    
    func fetchMatchesList(pageIndex: Int, completion: @escaping (Swift.Result<[Match], CSTVApiError>) -> Void) {
        requester.request(with: MatchesListServiceSetup.getMatches(page: pageIndex)) { (result: Swift.Result<[Match], CSTVApiError>) in
            switch result {
            case let .success(matches):
                completion(.success(matches))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
