//
//  AllLeagusViewModel.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import Foundation
class AllLeagusViewModel{
    
    var leaguesArray: [League]? {
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
    var updateData : (([League]?,Error?) -> Void) = {_ , _ in}

    init(SportsApi: SportsApi = NetworkManger()) {
        self.SportsApi = SportsApi
    }

    func fetchData(url:String){
        SportsApi.allLeaguesAPI(url: url) { leagues, error in
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
