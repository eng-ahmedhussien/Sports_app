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
    var arrayofTeams = [Team]()
    
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
    //  addActivityIndicator()
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
}
    
