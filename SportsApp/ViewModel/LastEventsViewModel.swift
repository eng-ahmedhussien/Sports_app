//
//  LastEvents.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 23/11/1443 AH.
//

import Foundation
class LastEventsViewModel{
    var lastEventsArray: [[String: String?]]? {
        didSet{
            updateData(lastEventsArray, nil)
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
        SportsApi.lastEvents(url: url) { lastevents, error in
            if let lastevents = lastevents {
                self.lastEventsArray = lastevents
                print(self.lastEventsArray!.count)
            }
            if let error = error {
                self.error = error
            }
        }
       
        
    }
    
}
