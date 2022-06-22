//
//  SportsApi.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import Foundation
protocol SportsApi{
    func allSports(url: String, completion: @escaping (([Sport]?, Error?) -> Void))
    func allLeaguesAPI(url: String, completion: @escaping (([League]? , Error?)->Void))
    func allTeams(url: String, completion: @escaping (([Team]? , Error?)->Void))
    func dictionaryTeam(url: String, completion: @escaping (([[String: String?]]?, Error?)->Void))
    func UpcomingEvents(url: String, completion: @escaping (([[String: String?]]? , Error?)->Void))
    func lastEvents(url: String, completion: @escaping (([Event]?, Error?) -> Void))
 
}
