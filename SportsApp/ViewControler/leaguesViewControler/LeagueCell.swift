//
//  LeagueCell.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 22/11/1443 AH.
//

import UIKit

class LeagueCell: UITableViewCell {

    
    @IBOutlet weak var nameLeague: UILabel!
    @IBOutlet weak var imageLeague: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func youtubeButton(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
