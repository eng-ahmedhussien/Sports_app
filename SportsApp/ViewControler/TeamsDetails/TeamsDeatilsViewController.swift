//
//  ViewController.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import UIKit
 class TeamsDeatilsViewController: UIViewController {


    @IBOutlet weak var discription: UITextView!
    @IBOutlet weak var stadiumname: UILabel!
    @IBOutlet weak var leaguename: UILabel!
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var imageback: UIImageView!
    
    var teamName = ""
    var leagueName = ""
    var descriptionTeam = ""
    var stadiumName = ""
    var teamImage = ""
    var iback  = ""
    var facebook = ""
    var instagram = ""
    var Twitter = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discription.text = descriptionTeam
        stadiumname.text = stadiumName
        leaguename.text = leagueName
        nameTeam.text = teamName
        

        let url1 = URL(string:teamImage)
        if let data = try? Data(contentsOf: url1!) {
            imageTeam.image = UIImage(data: data)
        }
    }

    @IBAction func tweter(_ sender: UIButton) {
        let appURL = URL(string:"https://www.\(Twitter)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            let webURL = URL(string:"https://www.\(Twitter)")!
            application.open(webURL)
            
        }
    }
    @IBAction func integram(_ sender: UIButton) {
        
        
        let appURL = URL(string:"https://www.\(instagram)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
           
            let webURL = URL(string:"https://www.\(instagram)")!
            application.open(webURL)
            
        }
    }
    
    @IBAction func facebook(_ sender: UIButton) {
        let appURL = URL(string:"https:/\(facebook)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            
            let webURL = URL(string:"https:/\(facebook)")!
            application.open(webURL)
            
        }
    }
}

