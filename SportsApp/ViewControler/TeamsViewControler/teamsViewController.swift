//
//  teamsViewController.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 22/11/1443 AH.
//

import UIKit

class teamsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet weak var teamsCollection: UICollectionView!
    
    
    var arrayOfTeams = [Team]()
    var leagueId = ""
    var favoriteCheck = false
    override func viewDidLoad() {
        super.viewDidLoad()
        teamsCollection.dataSource = self
        teamsCollection.delegate = self
        ScreenData()
    }
    func ScreenData(){
        let ViewModel = TeamsViewModel()
        ViewModel.fetchData(url:"\(URLs.allTeamsInLeague)\(leagueId)")
        print("\(URLs.allTeamsInLeague)\(leagueId)")
        ViewModel.updateData = { teams , error in
            if let teams = teams {
                self.arrayOfTeams = teams
                self.teamsCollection.reloadData()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfTeams.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCell
        cell?.nameTeam.text = arrayOfTeams[indexPath.row].strTeam
        
        let url = URL(string:arrayOfTeams[indexPath.row].strTeamBadge )
        if let data = try? Data(contentsOf: url!) {
            cell?.imageTeam.image = UIImage(data: data)
        }
        
        return cell!
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TeamsDeatilsViewController") as? TeamsDeatilsViewController
      //  vc?.nteam = arrayOfTeams[indexPath.row].strTeam
       // vc?.lname = arrayOfTeams[indexPath.row]
       // vc?.nameTeam.text = arrayOfTeams[indexPath.row].strTeam
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func returnToleagues(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var fac: UIToolbar!
    @IBAction func Favorite(_ sender: UIBarButtonItem) {
        print(favoriteCheck)
        favoriteCheck = !favoriteCheck
        print(favoriteCheck)
      
    }
}
