//
//  allLeagues2.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 24/11/1443 AH.
//

import Foundation
class AllLeagusVM{
    
    var leaguesArray: [Leagu]? {
        didSet{
            updateData(leaguesArray, nil)
        }
    }
    var error: Error? {
        didSet {
            updateData(nil, error)
        }
    }

    let SportsApi: SportsApi
    var updateData : (([Leagu]?,Error?) -> Void) = {_ , _ in}

    init(SportsApi: SportsApi = NetworkManger()) {
        self.SportsApi = SportsApi
    }

    func fetchData(url:String){
        SportsApi.allLeaguesBySport(url: url) { leagues, error in
            if let leagues = leagues {
                self.leaguesArray = leagues
                //print(sports.count)
            }
            if let error = error {
                self.error = error
            }
        }

    }
    
  
}
