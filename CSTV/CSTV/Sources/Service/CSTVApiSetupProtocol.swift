//
//  CSTVApiSetupProtocol.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol CSTVApiSetupProtocol {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : Any] { get }
    var headers: [String : String] { get }
}

extension CSTVApiSetupProtocol {
    var headers: [String : String] {
        return [:]
    }
    
    var parameters: [String : Any] {
        return [:]
    }
}
