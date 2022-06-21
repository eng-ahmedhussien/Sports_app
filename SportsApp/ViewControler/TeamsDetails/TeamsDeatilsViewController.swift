//
//  ViewController.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import UIKit

class TeamsDeatilsViewController: UIViewController {

    @IBOutlet weak var teamDescription: UILabel!
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var imageTeam: UIImageView!
    
    var nteam = ""
    var lname = ""
    var iteam = ""
    var dteam = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTeam.text = nteam
        leagueName.text = lname
        teamDescription.text =  dteam
        //iteam
    }


}

