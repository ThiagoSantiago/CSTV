//
//  MatchDetailsServiceSetup.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation

enum MatchDetailsServiceSetup: CSTVApiSetupProtocol {
    case getTeamsDetails(firstOpponentId: Int, secondOpponentId: Int)

    var endpoint: String {
        switch self {
        case let .getTeamsDetails(firstOpponentId, secondOpponentId):
            guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else { return "" }
            let url = baseUrl+"/csgo/teams?filter[id]=\(firstOpponentId),\(secondOpponentId)"
    
            return url
        }
    }
    
    var headers: [String : String] {
        guard let cstvKey = Bundle.main.object(forInfoDictionaryKey: "CSTVKey") as? String else { return [:] }
        return ["Content-Type":"application/json",
                "authorization":"Bearer \(cstvKey)"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTeamsDetails:
            return .get
        }
    }
}
