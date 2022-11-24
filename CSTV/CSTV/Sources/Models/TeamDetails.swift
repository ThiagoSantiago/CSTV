//
//  MatchDetails.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation

struct TeamDetails: Decodable {
    let id: Int
    let imageUrl: String?
    let modifiedAt: String?
    let name: String
    let players: [Player]
    let slug: String
}

struct Player: Decodable {
    let id: Int
    let age: Int?
    let birthday: String?
    let name: String
    let firstName: String?
    let imageUrl: String?
    let lastName: String?
    let modifiedAt: String?
    let nationality:String?
    let role: String?
    let slug: String
}
