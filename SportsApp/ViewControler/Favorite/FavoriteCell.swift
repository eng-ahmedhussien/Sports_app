//
//  FavoriteCell.swift
//  
//
//  Created by Ahmed Hussien on 23/11/1443 AH.
//

import UIKit

class FavoriteCell: UITableViewCell {

   
    @IBOutlet weak var leagueimage: UIImageView!
    @IBOutlet weak var leaguename: UILabel!
    var youtube = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func toutube(_ sender: UIButton) {
        let appURL = URL(string:"https://www.\(youtube)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string:"https://www.\(youtube)")!
            application.open(webURL)
            
        }
    }
    
}
