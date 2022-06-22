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

// MARK: - Welcome
struct Welcome: Codable {
    let event: [Event]
}

// MARK: - Event
struct Event: Codable {
    let idEvent: String
    let idSoccerXML: JSONNull?
    let idAPIfootball, strEvent, strEventAlternate, strFilename: String
    let strSport: StrSport
    let idLeague: String
    let strLeague: StrLeague
    let strSeason: StrSeason
    let strDescriptionEN, strHomeTeam, strAwayTeam, intHomeScore: String
    let intRound, intAwayScore: String
    let intSpectators: JSONNull?
    let strOfficial: String
    let strTimestamp: Date
    let dateEvent, dateEventLocal, strTime, strTimeLocal: String
    let strTVStation: JSONNull?
    let idHomeTeam, idAwayTeam: String
    let intScore, intScoreVotes: JSONNull?
    let strResult, strVenue: String
    let strCountry: StrCountry
    let strCity: String
    let strPoster: String
    let strSquare: String
    let strFanart: JSONNull?
    let strThumb: String
    let strBanner: String
    let strMap: JSONNull?
    let strTweet1, strTweet2, strTweet3: String
    let strVideo: String
    let strStatus: StrStatus
    let strPostponed: StrPostponed
    let strLocked: StrLocked
}

enum StrCountry: String, Codable {
    case england = "England"
}

enum StrLeague: String, Codable {
    case englishPremierLeague = "English Premier League"
}

enum StrLocked: String, Codable {
    case unlocked = "unlocked"
}

enum StrPostponed: String, Codable {
    case no = "no"
}

enum StrSeason: String, Codable {
    case the20212022 = "2021-2022"
}

enum StrSport: String, Codable {
    case soccer = "Soccer"
}

enum StrStatus: String, Codable {
    case matchFinished = "Match Finished"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func welcomeTask(with url: URL, completionHandler: @escaping (Welcome?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
