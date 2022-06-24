//
//  AllLeagues.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 23/11/1443 AH.
//

import Foundation
// MARK: - League
struct Leagu: Codable {
    let idLeague, strLeague, strSport, strYoutube, strBadge: String
    let strLeagueAlternate: String?
}

// MARK: -
struct allLeagu: Codable {
    let countries: [Leagu]
}
