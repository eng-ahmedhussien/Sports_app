//
//  LastEvent.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 23/11/1443 AH.
//

//import Foundation

//// MARK: - Welcome
//struct Events: Codable {
//    let event: [Event]
//}
//
//// MARK: - Event
//struct Event: Codable {
//    let idEvent: String
//
//    let idAPIfootball, strEvent, strEventAlternate, strFilename: String
//
//
//    let idLeague: String
//        let strSport: StrSport
//    let strLeague: StrLeague
//    let strSeason: StrSeason
////     let idSoccerXML: JSONNull?
////    let intSpectators: JSONNull?
////    let strTVStation: JSONNull?
////    let strFanart: JSONNull?
////     let strMap: JSONNull?
////     let intScore, intScoreVotes: JSONNull?
//     let strCountry: StrCountry
//
//        let strStatus: StrStatus
//        let strPostponed: StrPostponed
//        let strLocked: StrLocked
//
//    let strDescriptionEN, strHomeTeam, strAwayTeam, intHomeScore: String
//    let intRound, intAwayScore: String
//    let strOfficial: String
//    let strTimestamp: Date
//    let dateEvent, dateEventLocal, strTime, strTimeLocal: String
//    let idHomeTeam, idAwayTeam: String
//    let strResult, strVenue: String
//    let strCity: String
//    let strPoster: String
//    let strSquare: String
//    let strThumb: String
//    let strBanner: String
//    let strTweet1, strTweet2, strTweet3: String
//    let strVideo: String
//
//}
//
//enum StrCountry: String, Codable {
//    case england = "England"
//}
//
//enum StrLeague: String, Codable {
//    case englishPremierLeague = "English Premier League"
//}
//
//enum StrLocked: String, Codable {
//    case unlocked = "unlocked"
//}
//
//enum StrPostponed: String, Codable {
//    case no = "no"
//}
//
//enum StrSeason: String, Codable {
//    case the20212022 = "2021-2022"
//}
//
//enum StrSport: String, Codable {
//    case soccer = "Soccer"
//}
//
//enum StrStatus: String, Codable {
//    case matchFinished = "Match Finished"
//}
import Foundation


//// MARK: - Welcome
//struct Welcome: Codable {
//    let events: [event]
//}
//
//// MARK: - Event
//struct event: Codable {
//    let idEvent: String
//    let strEvent, strEventAlternate, strFilename: String
//    let idLeague: String
//    let strHomeTeam, strAwayTeam: String
//    let intHomeScore, intRound, intAwayScore: String
//    let strTimestamp, dateEvent: String
//    let strTime: String
//    let idHomeTeam, idAwayTeam: String
//    let intScore, intScoreVotes, strResult: String?
//    let strVenue: String
//    let strPoster, strSquare, strFanart, strThumb: String
//    let strBanner: String
//}


struct Welcome: Codable {
    let events: [[String: String?]]
}
