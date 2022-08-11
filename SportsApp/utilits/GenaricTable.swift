//
//  GenaricTable.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 10/12/1443 AH.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type){
        print(String(describing: Cell.self))
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }

    func dequeue<Cell: UITableViewCell>() -> Cell{
        let identifier = String(describing: Cell.self)
       // print("cell name \(identifier)")
        print(String(describing: Cell.self))
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
        
}
