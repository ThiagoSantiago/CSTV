//
//  Match.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation

struct Match: Decodable {
    let beginAt: String?
    let detailedStats: Bool?
    let draw: Bool?
    let endAt: String?
    let forfeit: Bool?
    let gameAdvantage: Int?
    let games: [Game]?
    let id: Int?
    let league: League?
    let leagueId: Int?
    let live: Live?
    let matchType: String?
    let modifiedAt: String?
    let name: String?
    let numberOfGames: Int?
    let opponents: [OpponentElement]?
    let originalScheduledAt: String?
    let rescheduled: Bool?
    let results: [Result]?
    let scheduledAt: String?
    let serie: Serie?
    let serieId: Int?
    let slug, status: String?
    let streamsList: [StreamsList]?
    let tournament: Tournament?
    let tournamentId: Int?
    let videogame: Videogame?
    let winnerType: String?
}



