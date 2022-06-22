//
//  decoder.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import Foundation
import Alamofire
func convertFromJson<T: Codable>(data:Data)->T?{
//    let jsonDecoder = JSONDecoder()
//    let decodedArray = try? jsonDecoder.decode(T.self, from: data)
//    return decodedArray
    
    let decoder = JSONDecoder()
    let decodedArray = try? decoder.decode(T.self, from: data)
    return decodedArray
}


//
//func checkForReachability()->Bool {
//    let networkReachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
//    var check = false
//    networkReachabilityManager?.listener = { status in
//        print("Network Status: \(status)")
//        switch status {
//            case .notReachable:
//                check = false
//                print("no connected with network")
//                //Show error here (no internet connection)
//            case .reachable(_), .unknown:
//                check = true
//                print("connected with network")
//        }
//    }
//    networkReachabilityManager?.startListening()
//    ret
//}


