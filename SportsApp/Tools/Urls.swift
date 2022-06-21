//
//  Urls.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import Foundation
struct URLs {
    
    static let allSports =  "https://www.thesportsdb.com/api/v1/json/2/all_sports.php"
    static let allLeaguesurl = "https://www.thesportsdb.com/api/v1/json/2/all_leagues.php"
    static let leagueDetailsById = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="
   // static let allTeamsInLeague =  "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id="
    static let allTeamsInLeague = "https://www.thesportsdb.com/api/v1/json/2/lookuptable.php?l="
    static let eventUrl       = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    static let upcomingUrl = "https://www.thesportsdb.com/api/v1/json/1/eventsround.php?id="
    
    

//    static let upcomingEvents = "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=" // leagueID & strCurrentSeason
    
    
}
