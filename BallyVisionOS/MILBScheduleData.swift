//
//  ScheduleData.swift
//  BallyLiveForVisionOS
//
//  Created by Rafael Quixabeira on 18/03/24.
//  Copyright © 2024 Bally's Corporation. All rights reserved.
//

import Foundation

// MARK: - MILBScheduleData
public class MILBScheduleData: Codable {
    public let date: String
    public let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case games = "games"
    }
    
    public init(date: String, games: [Game]) {
        self.date = date
        self.games = games
    }
}

// MARK: - Game
public class Game: Codable, Identifiable {
    public var id: Int?
    public var dateTime: String?
    public var officialDate: String?
    public var channelUUID: Int?
    public var channelName: String?
    public var noBroadcast: Bool?
    public var status: String?
    public var venue: String?
    public var publicCDNURL: String?
    public var isVariable: Bool?
    public var inning: Inning?
    public var homeTeam: Team?
    public var awayTeam: Team?
    public var selected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dateTime = "date_time"
        case officialDate = "official_date"
        case channelUUID = "channel_uuid"
        case channelName = "channel_name"
        case noBroadcast = "no_broadcast"
        case status = "status"
        case venue = "venue"
        case publicCDNURL = "public_cdn_url"
        case isVariable = "is_variable"
        case inning = "inning"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }

    public init(id: Int?, dateTime: String?, officialDate: String?, channelUUID: Int?, channelName: String?, noBroadcast: Bool?, status: String?, venue: String?, publicCDNURL: String?, isVariable: Bool?, inning: Inning?, homeTeam: Team?, awayTeam: Team?) {
        self.id = id
        self.dateTime = dateTime
        self.officialDate = officialDate
        self.channelUUID = channelUUID
        self.channelName = channelName
        self.noBroadcast = noBroadcast
        self.status = status
        self.venue = venue
        self.publicCDNURL = publicCDNURL
        self.isVariable = isVariable
        self.inning = inning
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}

// MARK: - Team
public class Team: Codable, Identifiable {
    public var id: Int?
    public var name: String?
    public var shortName: String?
    public var franchiseName: String?
    public var clubName: String?
    public var abbreviation: String?
    public var level: Level?
    public var league: Division?
    public var division: Division?
    public var parentOrg: Level?
    public var leagueRecord: LeagueRecord?
    public var score: String?
    public var logoSm: String?
    public var logoLg: String?
    public var logoRail: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case shortName = "short_name"
        case franchiseName = "franchise_name"
        case clubName = "club_name"
        case abbreviation = "abbreviation"
        case level = "level"
        case league = "league"
        case division = "division"
        case parentOrg = "parent_org"
        case leagueRecord = "league_record"
        case score = "score"
        case logoSm = "logo_sm"
        case logoLg = "logo_lg"
        case logoRail = "logo_rail"
    }
    
    var logoSMURL: URL? {
        guard let logoSm else { return nil }
        return URL(string: logoSm)
    }
    
    var leagueRecordsResume: String? {
        guard
            let leagueRecord,
            let wins = leagueRecord.wins,
            let losses = leagueRecord.losses
        else { return nil }
        
        return "\(wins)-\(losses)"
    }

    public init(id: Int?, name: String?, shortName: String?, franchiseName: String?, clubName: String?, abbreviation: String?, level: Level?, league: Division?, division: Division?, parentOrg: Level?, leagueRecord: LeagueRecord?, score: String?, logoSm: String?, logoLg: String?, logoRail: String?) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.franchiseName = franchiseName
        self.clubName = clubName
        self.abbreviation = abbreviation
        self.level = level
        self.league = league
        self.division = division
        self.parentOrg = parentOrg
        self.leagueRecord = leagueRecord
        self.score = score
        self.logoSm = logoSm
        self.logoLg = logoLg
        self.logoRail = logoRail
    }
}

// MARK: - Division
public class Division: Codable {
    public var id: Int?
    public var name: String?
    public var nameShort: String?
    public var abbreviation: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case nameShort = "name_short"
        case abbreviation = "abbreviation"
    }

    public init(id: Int?, name: String?, nameShort: String?, abbreviation: String?) {
        self.id = id
        self.name = name
        self.nameShort = nameShort
        self.abbreviation = abbreviation
    }
}

// MARK: - LeagueRecord
public class LeagueRecord: Codable {
    public var wins: String?
    public var losses: String?
    public var pct: String?

    enum CodingKeys: String, CodingKey {
        case wins = "wins"
        case losses = "losses"
        case pct = "pct"
    }

    public init(wins: String?, losses: String?, pct: String?) {
        self.wins = wins
        self.losses = losses
        self.pct = pct
    }
}

// MARK: - Level
public class Level: Codable {
    public var id: Int?
    public var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    public init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: - Inning
public class Inning: Codable {
    public var currentInning: String?
    public var inningHalf: String?

    enum CodingKeys: String, CodingKey {
        case currentInning = "currentInning"
        case inningHalf = "inningHalf"
    }

    public init(currentInning: String?, inningHalf: String?) {
        self.currentInning = currentInning
        self.inningHalf = inningHalf
    }
}
