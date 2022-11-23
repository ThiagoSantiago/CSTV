//
//  MatchesListServiceSetup.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation

enum MatchesListServiceSetup: CSTVApiSetupProtocol {
    case getMatches(page: Int)
    
    var endpoint: String {
        switch self {
        case let .getMatches(page):
            let todayDate = Date.now.getStringDate(toFormat: "yyyy-MM-dd")
            guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else { return "" }
            let url = baseUrl+"/csgo/matches?filter[finished]=false&filter[begin_at]=\(todayDate)&sort=begin_at&page[size]=10&page[number]=\(page)"
            
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
        case .getMatches:
            return .get
        }
    }
}
