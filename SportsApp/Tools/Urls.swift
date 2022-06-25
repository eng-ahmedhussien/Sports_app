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
    static let allLeaguesBySport = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s="
    static let upcomingUrl = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id="
    static let allTeamsInLeague = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=" //by leagua name more details
    static let lastevents  = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id="
    static let leagueDetailsById = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="
    
    //static let allTeamsInLeagueById = "https://www.thesportsdb.com/api/v1/json/2/lookuptable.php?l=" // by leagua id
   // static let eventUrl  = "https://www.thesportsdb.com/api/v1/json/2/searchfilename.php?e=English_Premier_League_2022-05-22"
    //      = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    //    static let upcomingEvents = "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=" // leagueID & strCurrentSeason
    
    
}
