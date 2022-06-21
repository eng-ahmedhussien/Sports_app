//
//  SportLegs.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import Foundation
// MARK: - League
struct League: Codable {
    let idLeague, strLeague, strSport: String
    let strLeagueAlternate: String?
}

// MARK: -
struct allLeague: Codable {
    let leagues: [League]
}

