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
    var youtube = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func youtubeButton(_ sender: UIButton) {
        let appURL = URL(string:"https://www.\(youtube)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string:"https://www.\(youtube)")!
            application.open(webURL)
            
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
