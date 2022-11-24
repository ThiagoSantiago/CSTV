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

struct Game: Decodable {
    let beginAt: String?
    let complete: Bool?
    let detailedStats: Bool?
    let endAt: String?
    let finished: Bool?
    let forfeit: Bool?
    let id: Int?
    let matchId: Int?
    let position: Int?
    let status: String?
    let winner: Winner?
    let winnerType: String?
}

struct Winner: Decodable {
    let id: Int?
    let type: String?
}

struct League: Decodable {
    let id: Int?
    let imageUrl: String?
    let modifiedAt: String?
    let name: String?
    let slug: String?
    let url: String?
}

struct Live: Decodable {
    let opensAt: String?
    let supported: Bool?
    let url: String?
}

struct OpponentElement: Decodable {
    let opponent: Opponent?
    let type: String?
}

struct Opponent: Decodable {
    let acronym: String?
    let id: Int?
    let imageUrl: String?
    let location: String?
    let modifiedAt: String?
    let name: String?
    let slug: String?
}

struct Result: Codable {
    let score: Int?
    let teamId: Int?
}

struct Serie: Codable {
    let beginAt: String?
    let endAt: String?
    let fullName: String?
    let id: Int?
    let leagueId: Int?
    let modifiedAt: String?
    let name: String?
    let season, slug: String?
    let winnerId: Int?
    let winnerType: String?
    let year: Int?
}

struct StreamsList: Codable {
    let embedUrl: String?
    let language: String?
    let main: Bool?
    let official: Bool?
    let rawUrl: String?
}

struct Tournament: Codable {
    let beginAt: String?
    let endAt: String?
    let id: Int?
    let leagueId: Int?
    let liveSupported: Bool?
    let modifiedAt: String?
    let name: String?
    let prizepool: String?
    let serieId: Int?
    let slug: String?
    let tier: String?
    let winnerId: Int?
    let winnerType: String?
}

struct Videogame: Codable {
    let id: Int?
    let name: String?
    let slug: String?
}
