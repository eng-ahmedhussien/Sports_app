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
    var arrayofleagus2 = [Leagu]()
    var arrayofTeams = [Team]()
    var arrayofDicTeams = [[String: String?]]()
    var arrayofEvents = [[String: String?]]()
    var arrayofLastEvents = [[String: String?]]()
    
    //MARK: allSports
    func allSports(url: String, completion: @escaping (([Sport]?, Error?) -> Void)) {
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
//                    let decodedArray:[Sport] = convertFromJson(data: data) ?? []
//                    print(decodedArray.count)
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(AllSports.self, from: data)
                    self.arrayofSports = decodedArray!.sports
                   // print(self.decodedSports.count)
                    completion(self.arrayofSports,nil)
                }else{
                    print("No Data")
                    return
                }
            }else{
                print("error \(String(describing:response.result.error))")
            }
        }
    }
    //MARK: allLeagues
    public func allLeaguesAPI(url: String , completion: @escaping ([League]? , Error?)->Void) {
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(allLeague.self, from: data)
                    self.arrayofleagus = decodedArray!.leagues
                   // print(self.decodedSports.count)
                    completion(self.arrayofleagus,nil)
                }else{
                    print("No Data")
                    return
                }
            }else{
                print("error \(String(describing:response.result.error))")
            }
        }
        
    }
    //MARK: allLeaguesbySport
    func allLeaguesBySport(url: String, completion: @escaping (([Leagu]?, Error?) -> Void)) {
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(allLeagu.self, from: data)
                    self.arrayofleagus2 = decodedArray!.countries
                   // print(self.decodedSports.count)
                    completion(self.arrayofleagus2,nil)
                }else{
                    print("No Data")
                    return
                }
            }else{
                print("error \(String(describing:response.result.error))")
            }
        }
        
    }
    //MARK: allTeams
    func allTeams(url: String, completion: @escaping (([Team]?, Error?) -> Void)) {
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(Teams.self, from: data)
                    self.arrayofTeams = decodedArray!.table
                    // print(self.decodedSports.count)
                    completion(self.arrayofTeams,nil)
                }else{
                    print("No Data")
                    return
                }
            }else{
                print("error \(String(describing:response.result.error))")
            }
        }
    }
    //MARK: UpcomingEvents
    func UpcomingEvents(url: String, completion: @escaping (([[String : String?]]?, Error?) -> Void)) {
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(Upcoming.self, from: data)
                    if let d = decodedArray?.events{
                        self.arrayofEvents = d
                        completion(self.arrayofEvents,nil)
                    }
                    else{
                        print("No upcoming events")
                    }
                    
                }else{
                    print("No Data")
                    return
                }
            }else{
                print("error \(String(describing:response.result.error))")
            }
        }
    }
    //MARK: dictionaryTeam
    func dictionaryTeam(url: String, completion: @escaping (([[String : String?]]?, Error?) -> Void)) {
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(DictionaryTeam.self, from: data)
                    if let d = decodedArray?.teams{
                        self.arrayofDicTeams = d
                        completion(self.arrayofDicTeams,nil)
                    }
                    else{
                        print("No  teams ")
                    }
                    
                }else{
                    print("No Data")
                    return
                }
            }else{
                print("error \(String(describing:response.result.error))")
            }
        }
    }
    //MARK: lastEvents
    func lastEvents(url: String, completion: @escaping (([[String: String?]]?, Error?) -> Void)) {
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(Welcome.self, from: data)
                    if let  decodedArray = decodedArray{
                        self.arrayofLastEvents = decodedArray.events
                         print("arrayofLastEvents  found")
                        completion(self.arrayofLastEvents,nil)
                    }
                    else{
                        print( url)
                        print(" arrayofLastEvents not found")
                    }
                   
                }else{
                    print("No Data")
                    return
                }
            }else{
                print("error \(String(describing:response.result.error))")
            }
        }
    }
    
    
    
    
    
}
    
