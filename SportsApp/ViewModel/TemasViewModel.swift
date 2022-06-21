//
//  TemasViewModel.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 22/11/1443 AH.
//

import Foundation
class TeamsViewModel{
    var teamsArray: [Team]? {
        didSet{
            updateData(teamsArray, nil)
        }
    }
    var error: Error? {
        didSet {
            updateData(nil, error)
        }
    }
    
    let SportsApi: SportsApi
    var updateData : (([Team]?,Error?) -> Void) = {_ , _ in}
    
    init(SportsApi: SportsApi = NetworkManger()) {
        self.SportsApi = SportsApi
    }
    
    func fetchData(url:String){
        SportsApi.allTeams(url: url) { teams, error in
            if let teams = teams {
                self.teamsArray = teams
                //print(sports.count)
            }
            if let error = error {
                self.error = error
            }
        }
        
    }
    
}
