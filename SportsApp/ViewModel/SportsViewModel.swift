//
//  ViewModel.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import Foundation
class SportsViewModel{
    var sportsArray: [Sport]? {
        didSet{
            updateData(sportsArray, nil)
        }
    }
    var error: Error? {
        didSet {
            updateData(nil, error)
        }
    }
    
    let SportsApi: SportsApi
    var updateData : (([Sport]?,Error?) -> Void) = {_ , _ in}
    
    init(SportsApi: SportsApi = NetworkManger()) {
        self.SportsApi = SportsApi
    }
    
    func fetchData(url:String){
        SportsApi.allSports(url: url) { sports, error in
            if let sports = sports {
                self.sportsArray = sports
                //print(sports.count)
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
}
