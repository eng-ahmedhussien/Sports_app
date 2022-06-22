//
//  createAlart.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 23/11/1443 AH.
//

import Foundation
import UIKit

func creatAlert (title:String,message:String){
       let alart = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
       alart.addAction(okButton)
       //present(alart, animated: true, completion: nil)
     
   }
