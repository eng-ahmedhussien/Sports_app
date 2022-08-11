//
//  NetworkManger.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class NetworkManger:SportsApi{
    
    var arrayofSports = [Sport]()
    var arrayofleagus = [League]()
    var arrayofleagusBySport = [Leagu]()
    var arrayofTeams = [Team]()
    var arrayofDicTeams = [[String: String?]]()
    var arrayofEvents = [[String: String?]]()
    var arrayofLastEvents = [[String: String?]]()
    
    //MARK: allSports
    func allSports(url: String, completion: @escaping (([Sport]?, Error?) -> Void)) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
                case .success( _):
                    guard let data = response.data else{return}
                    do {
                        let decodedData = try JSONDecoder().decode(AllSports.self, from:data)
                        completion(decodedData.sports,nil)
                    } catch let jsonError {
                        completion(nil,jsonError)
                    }

                case .failure(let error):
                    completion(nil,error)
            }
        }


    }
    //MARK: allLeagues
    public func allLeaguesAPI(url: String , completion: @escaping ([League]? , Error?)->Void) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
                case .success( _):
                    guard let data = response.data else{return}
                    do {
                        let decodedData = try JSONDecoder().decode(allLeague.self, from:data)
                        completion(decodedData.leagues,nil)
                    } catch let jsonError {
                        completion(nil,jsonError)
                    }

                case .failure(let error):
                    completion(nil,error)
            }

        }
    }
    //MARK: allLeaguesbySport
    func allLeaguesBySport(url: String, completion: @escaping (([Leagu]?, Error?) -> Void)) {
        Alamofire.request(url).responseJSON { response in
                   switch response.result {
                       case .success( _):
                           guard let data = response.data else{return}
                           do {
                               let decodedData = try JSONDecoder().decode(allLeagu.self, from:data)
                               completion(decodedData.countries,nil)
                           } catch let jsonError {
                               completion(nil,jsonError)
                           }

                       case .failure(let error):
                           completion(nil,error)
                   }

               }
        
        
    }
    //MARK: allTeams
    func allTeams(url: String, completion: @escaping (([Team]?, Error?) -> Void)) {
        Alamofire.request(url).responseJSON { response in
                   switch response.result {
                       case .success( _):
                           guard let data = response.data else{return}
                           do {
                               let decodedData = try JSONDecoder().decode(Teams.self, from:data)
                               completion(decodedData.table,nil)
                           } catch let jsonError {
                               completion(nil,jsonError)
                           }

                       case .failure(let error):
                           completion(nil,error)
                   }

               }
    }
    //MARK: dictionaryTeam
    func dictionaryTeam(url: String, completion: @escaping (([[String : String?]]?, Error?) -> Void)) {
        Alamofire.request(url).responseJSON { response in
                   switch response.result {
                       case .success( _):
                           guard let data = response.data else{return}
                           do {
                               let decodedData = try JSONDecoder().decode(DictionaryTeam.self, from:data)
                               completion(decodedData.teams,nil)
                           } catch let jsonError {
                               completion(nil,jsonError)
                           }

                       case .failure(let error):
                           completion(nil,error)
                   }

               }
    }
    //MARK: UpcomingEvents
    func UpcomingEvents(url: String, completion: @escaping (([[String : String?]]?, Error?) -> Void)) {
        Alamofire.request(url).responseJSON { response in
                   switch response.result {
                       case .success( _):
                           guard let data = response.data else{return}
                           do {
                               let decodedData = try JSONDecoder().decode(Upcoming.self, from:data)
                               completion(decodedData.events,nil)
                           } catch let jsonError {
                               completion(nil,jsonError)
                           }

                       case .failure(let error):
                           completion(nil,error)
                   }

               }
    }
    //MARK: lastEvents
    func lastEvents(url: String, completion: @escaping (([[String: String?]]?, Error?) -> Void)) {
        Alamofire.request(url).responseJSON { response in
                   switch response.result {
                       case .success( _):
                           guard let data = response.data else{return}
                           do {
                               let decodedData = try JSONDecoder().decode(Welcome.self, from:data)
                               completion(decodedData.events,nil)
                           } catch let jsonError {
                               completion(nil,jsonError)
                           }

                       case .failure(let error):
                           completion(nil,error)
                   }

               }
       
}
    
}
