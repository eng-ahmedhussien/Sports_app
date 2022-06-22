//
//  teamsViewController.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 22/11/1443 AH.
//

import UIKit
import CoreData

class teamsViewController: UIViewController{
    @IBOutlet weak var teamsCollection: UICollectionView!
    @IBOutlet weak var UpcomingEventsCollection: UICollectionView!
    @IBOutlet weak var LastEventsCollection: UICollectionView!
    @IBOutlet weak var fac: UIToolbar!
    
    var arrayOfTeams = [Team]()
    var arrayOfDicTeams = [[String: String?]]()
    var arrayOfEvents = [[String: String?]]()
    var arrayOfLeagues = [League]()
    var arrayOfLeaguesCore = [CoreLeague]()
    var arrayOfLastEvents = [Event]()
    var leagueId = ""
    var leaguename = ""
    var favoriteCheck = false
    var db = DBManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamsCollection.dataSource = self
        teamsCollection.delegate = self
        
        UpcomingEventsCollection.dataSource = self
        UpcomingEventsCollection.delegate = self
        
        LastEventsCollection.dataSource = self
        LastEventsCollection.delegate = self
        
        teamsScreenData()
        upcomingScreenData()
        LastEventScreenData()
    }
    func teamsScreenData(){
       
        let ViewModel = DicTeamsViewModel()
        let leagueNameArray = leaguename.split(separator: " ")
        var leagueName = ""
        for i in 0..<leagueNameArray.count{
            if i == leagueNameArray.count-1{
                leagueName += "\(leagueNameArray[i])"
            }
            else{
            leagueName += "\(leagueNameArray[i])%20"
            }
        }
        
        ViewModel.fetchData(url:"\(URLs.allTeamsInLeague)\(leagueName)")
        print("\(URLs.allTeamsInLeague)\(leagueName)")
        ViewModel.updateData = { dicteams , error in
            if let dicteams = dicteams {
                self.arrayOfDicTeams = dicteams
                self.teamsCollection.reloadData()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
        //let ViewModel = TeamsViewModel()
//        ViewModel.fetchData(url:"\(URLs.allTeamsInLeague)\(newurl)")
//        print("\(URLs.allTeamsInLeague)\(leagueId)")
//        ViewModel.updateData = { teams , error in
//            if let teams = teams {
//                self.arrayOfTeams = teams
//                self.teamsCollection.reloadData()
//            }
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }
    }
    func upcomingScreenData(){
        let ViewModel = UpcomingEventViewModel()
        ViewModel.fetchData(url:"\(URLs.upcomingUrl)\(leagueId)")
        print("\(URLs.upcomingUrl)\(leagueId)")
        ViewModel.updateData = { events , error in
            if let events = events {
                self.arrayOfEvents = events
                self.UpcomingEventsCollection.reloadData()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func LastEventScreenData(){
         let ViewModel = LastEventsViewModel()
         let leagueNameArray = leaguename.split(separator: " ")
         var leagueName = ""
//         for i in 0..<leagueNameArray.count{
//             if i == leagueNameArray.count-1{
//                 leagueName += "\(leagueNameArray[i])%202021"
//             }
//             else{
//             leagueName += "\(leagueNameArray[i])%20"
//             }
//         }
         ViewModel.fetchData(url:"\(URLs.eventUrl)")
        // print("\(URLs.eventUrl)\(leagueName)")
         ViewModel.updateData = { lastevents , error in
             if let lastevents = lastevents {
                 self.arrayOfLastEvents = lastevents
                 self.LastEventsCollection.reloadData()
             }
             if let error = error {
                 print(error.localizedDescription)
             }
         }
  
    }
    func check()->Bool{
        arrayOfLeaguesCore = db.fetchData(appDelegate: appDelegate)
        for j in self.arrayOfLeaguesCore{
            if j.id == leagueId{
                db.delete(CoreLeague: j, appDelegate: appDelegate)
                return true
            }
        }
        return false
        
    }
    
    @IBAction func returnToleagues(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func Favorite(_ sender: UIBarButtonItem) {
        favoriteCheck = !favoriteCheck
        let ViewModel = AllLeagusViewModel()
        ViewModel.fetchData(url:URLs.allLeaguesurl)

        ViewModel.updateData = { leagues , error in
            if let leagues = leagues {
                if   self.check() == false{
                    self.arrayOfLeagues = leagues
                    for i in self.arrayOfLeagues{
                        if i.idLeague == self.leagueId{
                            self.db.addMovie(appDelegate: self.appDelegate, id: i.idLeague, name: i.strLeague, sport: i.strSport, alternate: i.strLeagueAlternate!)
                        }
                    }
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
   
}
extension teamsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.teamsCollection{
            print("in teamsCollection")
            return arrayOfDicTeams.count
        }
        else if collectionView == self.UpcomingEventsCollection{
            print("in UpcomingEventsCollection")
            return arrayOfEvents.count
        }
        else{
            print("in lastEventsCollection")
            return arrayOfLastEvents.count
        }
      
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.teamsCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCell
            cell?.nameTeam.text = arrayOfDicTeams[indexPath.row]["strTeam"] as! String
            let url = URL(string:(arrayOfDicTeams[indexPath.row]["strTeamBadge"])!! )
            if let data = try? Data(contentsOf: url!) {
                cell?.imageTeam.image = UIImage(data: data)
            }
//            cell?.nameTeam.text = arrayOfTeams[indexPath.row].strTeam
//            let url = URL(string:arrayOfTeams[indexPath.row].strTeamBadge )
//            if let data = try? Data(contentsOf: url!) {
//                cell?.imageTeam.image = UIImage(data: data)
//
//            }
            cell!.layer.cornerRadius = 20
            return cell!
        }
        else if collectionView == self.UpcomingEventsCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventsCell", for: indexPath) as? UpcomingEventsCell
            cell?.eventData.text = arrayOfEvents[indexPath.row]["dateEvent"] as? String
            cell?.eventName.text = arrayOfEvents[indexPath.row]["strEvent"] as? String
            cell?.t1.text = arrayOfEvents[indexPath.row]["strHomeTeam"] as? String
            cell?.t2.text = arrayOfEvents[indexPath.row]["strAwayTeam"] as? String
            cell!.layer.cornerRadius = 20
        
        return cell!
//            {
//
//                let url = URL(string:(self.arrayOfEvents[indexPath.row]["strThumb"] as? String)!)
//                if let url = url {
//                    print("scuss")
//                    let data = try? Data(contentsOf: url)
//                    cell?.eventImage.image = UIImage(data: data!)
//                    print(url)
//                }
//                else{
//                    print("error")}
//            }
            
        }
         else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastEventCell", for: indexPath) as? LastEventCell
                
                cell?.t1.text = arrayOfLastEvents[indexPath.row].strHomeTeam
            
    //            cell?.nameTeam.text = arrayOfTeams[indexPath.row].strTeam
    //            let url = URL(string:arrayOfTeams[indexPath.row].strTeamBadge )
    //            if let data = try? Data(contentsOf: url!) {
    //                cell?.imageTeam.image = UIImage(data: data)
    //
    //            }
                cell!.layer.cornerRadius = 20
                return cell!
           
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.teamsCollection{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TeamsDeatilsViewController") as? TeamsDeatilsViewController
            vc?.tname = arrayOfDicTeams[indexPath.row]["strTeam"]!!
            vc?.lname = arrayOfDicTeams[indexPath.row]["strLeague"]!!
            vc?.sname = arrayOfDicTeams[indexPath.row]["strStadium"]!!
            vc?.ifront = arrayOfDicTeams[indexPath.row]["strTeamBadge"]!!
            vc?.iback = arrayOfDicTeams[indexPath.row]["strTeamFanart2"]!!
            vc?.dteam = arrayOfDicTeams[indexPath.row]["strDescriptionEN"]!!
            vc?.instagram = arrayOfDicTeams[indexPath.row]["strInstagram"]!!
            vc?.facebook = arrayOfDicTeams[indexPath.row]["strFacebook"]!!
            vc?.Twitter = arrayOfDicTeams[indexPath.row]["strTwitter"]!!
            self.present(vc!, animated: true, completion: nil)
        }
        
    }
    // MARK: UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 209.0, height: 200.0)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
