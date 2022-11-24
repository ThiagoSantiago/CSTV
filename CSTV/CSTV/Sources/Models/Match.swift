//
//  Match.swift
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

struct MatchData {
    let firstOponentName: String
    let firstOponentLogo: String
    let secondOponentName: String
    let secondOponentLogo: String
    let beginTime: String
    let endTime: String
    let gameStatus: String
    let leagueImage: String
    let leagueName: String
    let serieName: String
}

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



