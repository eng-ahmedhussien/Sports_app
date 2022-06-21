//
//  AllTeams.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 22/11/1443 AH.
//

import Foundation
// MARK: - Welcome
struct Teams: Codable {
    let table: [Team]
}

// MARK: - Table
struct Team: Codable {
    let idStanding, intRank, idTeam, strTeam: String
    let strTeamBadge: String
    let idLeague: String
   // let strLeague: StrLeague
    //let strSeason: StrSeason
    let strForm, strDescription, intPlayed, intWin: String
    let intLoss, intDraw, intGoalsFor, intGoalsAgainst: String
    let intGoalDifference, intPoints: String
   // let dateUpdated: DateUpdated
}


//enum DateUpdated: String, Codable {
//    case the20220620230047 = "2022-06-20 23:00:47"
//}
//enum StrLeague: String, Codable {
//    case germanBundesliga = "German Bundesliga"
//    case englishPremierLeague = "English Premier League"
//    "English League Championship"
//    "Scottish Premier League"
//    "Italian Serie A"
//    "French Ligue 1"
//}
//
//enum StrSeason: String, Codable {
//    case the20212022 = "2021-2022"
//}
