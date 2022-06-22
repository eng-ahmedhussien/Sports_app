//
//  DicTeamsViewModel.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 23/11/1443 AH.
//

import Foundation
class DicTeamsViewModel{
    var dicteamsArray: [[String: String?]]? {
        didSet{
            updateData(dicteamsArray, nil)
        }
    }
    var error: Error? {
        didSet {
            updateData(nil, error)
        }
    }
    
    let SportsApi: SportsApi
    var updateData : (([[String: String?]]?,Error?) -> Void) = {_ , _ in}
    init(SportsApi: SportsApi = NetworkManger()) {
        self.SportsApi = SportsApi
    }
    
    func fetchData(url:String){
        SportsApi.dictionaryTeam(url: url) { dicteams, error in
            if let dicteams = dicteams {
                self.dicteamsArray = dicteams
                //print(sports.count)
            }
            if let error = error {
                self.error = error
            }
        }
        
    }
    
}
