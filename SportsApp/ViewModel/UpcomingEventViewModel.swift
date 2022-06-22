//
//  UpcomingEventViewModel.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 22/11/1443 AH.
//

import Foundation
class UpcomingEventViewModel{
    var eventsArray: [[String: String?]]? {
        didSet{
            updateData(eventsArray, nil)
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
        SportsApi.UpcomingEvents(url: url) { events, error in
            if let events = events {
                self.eventsArray = events
                //print(sports.count)
            }
            if let error = error {
                self.error = error
            }
        }
       
        
    }
    
}
