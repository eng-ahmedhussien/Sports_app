//
//  SportCell.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import UIKit

class SportCell: UICollectionViewCell {
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    
    func configureCell(imageSport: String, nameSport: String) {
        sportName.text = nameSport
        let url = URL(string:imageSport)
        if let data = try? Data(contentsOf: url!) {
            sportImage.image = UIImage(data: data)
        }
    }
}
