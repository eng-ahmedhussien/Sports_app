//
//  decoder.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import Foundation

func convertFromJson<T: Codable>(data:Data)->T?{
//    let jsonDecoder = JSONDecoder()
//    let decodedArray = try? jsonDecoder.decode(T.self, from: data)
//    return decodedArray
    
    let decoder = JSONDecoder()
    let decodedArray = try? decoder.decode(T.self, from: data)
    return decodedArray
}
