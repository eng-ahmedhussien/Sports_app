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
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(AllSports.self, from: data)
                    if let decodedArray  = decodedArray?.sports{
                        self.arrayofSports = decodedArray
                        completion(self.arrayofSports,nil)
                    }
                    else{
                        print(" arrayofSports nill  ")
                    }
                    // print(self.decodedSports.count)
                    
                }else{
                    print("No Data in arrayofSports")
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
                    if let decodedArray  = decodedArray?.leagues{
                        self.arrayofleagus = decodedArray
                       // print(self.decodedSports.count)
                        completion(self.arrayofleagus,nil)
                    }
                    else{
                        print(" arrayofleagus nill  ")
                    }
                }else{
                    print("No Data arrayofleagus")
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
                    if let decodedArray = decodedArray?.countries{
                        self.arrayofleagusBySport = decodedArray
                       // print(self.decodedSports.count)
                        completion(self.arrayofleagusBySport,nil)
                    }
                    else{
                        print("arrayofleagusBySport is nill")
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
    //MARK: allTeams
    func allTeams(url: String, completion: @escaping (([Team]?, Error?) -> Void)) {
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(Teams.self, from: data)
                    if let decodedArray = decodedArray?.table{
                        self.arrayofTeams = decodedArray
                        completion(self.arrayofTeams,nil)
                    }
                    else{
                        print("arrayofTeams is nil")
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
                    if let decodedArray = decodedArray?.teams{
                        self.arrayofDicTeams = decodedArray
                        completion(self.arrayofDicTeams,nil)
                    }
                    else{
                        print("arrayofDicTeams nill")
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
    //MARK: UpcomingEvents
    func UpcomingEvents(url: String, completion: @escaping (([[String : String?]]?, Error?) -> Void)) {
        Alamofire.request(url).validate().responseJSON { response in
            if response.result.isSuccess
            {
                if let data = response.data{
                    let decoder = JSONDecoder()
                    let decodedArray = try? decoder.decode(Upcoming.self, from: data)
                    if let decodedArray = decodedArray?.events{
                        self.arrayofEvents = decodedArray
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
    
