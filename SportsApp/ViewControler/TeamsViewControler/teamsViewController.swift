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
    @IBOutlet weak var favoriteB: UIBarButtonItem!
    
    var arrayOfTeams = [Team]()
    var arrayOfDicTeams = [[String: String?]]()
    var arrayOfEvents = [[String: String?]]()
    var arrayOfLeagues = [Leagu]()
    var arrayOfLeaguesCore = [CoreLeague]()
    var arrayOfLastEvents = [[String: String?]]()
    var leagueId = ""
    var leaguename = ""
    var sportName  = ""
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
    override func viewWillAppear(_ animated: Bool) {
        if favoriteCheck() == true {
            favoriteB.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal, barMetrics: .default)
        }
        else{
            favoriteB.setBackgroundImage(UIImage(systemName: "star"), for: .normal, barMetrics: .default)
        }
    }
    //MARK: teamsScreenData
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
        ViewModel.updateData = { teams , error in
            if let teams = teams {
                self.arrayOfDicTeams = teams
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
    
    //MARK: upcomingScreenData
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
    
    //MARK: LastEventScreenData
    func LastEventScreenData(){
//         let leagueNameArray = leaguename.split(separator: " ")
//         var leagueName = ""
//         for i in 0..<leagueNameArray.count{
//             if i == leagueNameArray.count-1{
//                 leagueName += "\(leagueNameArray[i])%202021"
//             }
//             else{
//             leagueName += "\(leagueNameArray[i])%20"
//             }
//         }
        let ViewModel = LastEventsViewModel()
        ViewModel.fetchData(url:"\(URLs.lastevents)\(leagueId)")
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
    
    //MARK: checkIfExistInCoreData
    func checkIfExistInCoreData()->Bool{
        arrayOfLeaguesCore = db.fetchData(appDelegate: appDelegate)
        for j in self.arrayOfLeaguesCore{
            if j.id == leagueId{
                db.delete(CoreLeague: j, appDelegate: appDelegate)
                createAlart(title: "sccuess", message: "league removed from favorite")
                return true
            }
        }
        return false
    }
    func favoriteCheck()->Bool{
        arrayOfLeaguesCore = db.fetchData(appDelegate: appDelegate)
        for j in self.arrayOfLeaguesCore{
            if j.id == leagueId{
                return true
            }
        }
        return false
    }
    
    //MARK: back to league view
    @IBAction func returnToleagues(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: favorite button
    @IBAction func Favorite(_ sender: UIBarButtonItem) {
        let ViewModel = AllLeagusBySport()
        ViewModel.fetchData(url:"\(URLs.allLeaguesBySport)\(sportName)")
        ViewModel.updateData = { leagues , error in
            if let leagues = leagues {
                if  self.checkIfExistInCoreData() == false{
                    self.arrayOfLeagues = leagues
                    for i in self.arrayOfLeagues{
                        if i.idLeague == self.leagueId{
                            self.db.addMovie(appDelegate: self.appDelegate, id: i.idLeague, name: i.strLeague, sport: i.strSport, alternate: i.strLeagueAlternate!,image: i.strBadge,youtube: i.strYoutube)
                        }
                    }
                    self.favoriteB.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal, barMetrics: .default)
                    self.createAlart(title: "sccuess", message: "league added")
                }
                
               // sender.setBackgroundImage(UIImage(systemName: "star"), for: .normal, barMetrics: .default)
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
//        favoriteCheck = !favoriteCheck
//        let ViewModel = AllLeagusViewModel()
//        ViewModel.fetchData(url:URLs.allLeaguesBySport)
//
//        ViewModel.updateData = { leagues , error in
//            if let leagues = leagues {
//                if   self.check() == false{
//                    self.arrayOfLeagues = leagues
//                    for i in self.arrayOfLeagues{
//                        if i.idLeague == self.leagueId{
//                            self.db.addMovie(appDelegate: self.appDelegate, id: i.idLeague, name: i.strLeague, sport: i.strSport, alternate: i.strLeagueAlternate!)
//                        }
//                    }
//                }
//            }
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }
        
    }
    
    func createAlart(title:String,message:String){
            let alart = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
            alart.addAction(okButton)
             present(alart, animated: true, completion: nil)
            
        }
}

// MARK: teamsViewController
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

            if  let url = URL(string:(((arrayOfDicTeams[indexPath.row]["strTeamBadge"] ?? " ") ?? " ")) ){
                if let data = try? Data(contentsOf: url) {
                    cell?.imageTeam.image = UIImage(data: data)
                }
            }
          
            
            cell!.layer.borderColor = UIColor.black.cgColor
            cell!.layer.borderWidth = 1
            cell?.layer.cornerRadius  = 20
            cell!.clipsToBounds = true
            return cell!
        }
        else if collectionView == self.LastEventsCollection{
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastEventCell", for: indexPath) as? LastEventCell
            
            cell?.t1.text = arrayOfLastEvents[indexPath.row]["strHomeTeam"] as? String
            cell?.t2.text = arrayOfLastEvents[indexPath.row]["strAwayTeam"] as? String
            cell!.s1.text = arrayOfLastEvents[indexPath.row]["intHomeScore"] as? String
            cell?.s2.text = arrayOfLastEvents[indexPath.row]["intAwayScore"] as? String
            cell?.data.text = arrayOfLastEvents[indexPath.row]["dateEvent"] as? String
            cell?.time.text = arrayOfLastEvents[indexPath.row]["strTime"] as? String
            
            cell!.layer.borderColor = UIColor.black.cgColor
            cell!.layer.borderWidth = 1
            cell?.layer.cornerRadius  = 20
            cell!.clipsToBounds = true
            return cell!
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventsCell", for: indexPath) as? UpcomingEventsCell
            cell?.eventData.text = arrayOfEvents[indexPath.row]["dateEvent"] as? String
            cell?.t1.text = arrayOfEvents[indexPath.row]["strHomeTeam"] as? String
            cell?.t2.text = arrayOfEvents[indexPath.row]["strAwayTeam"] as? String
            cell!.layer.borderColor = UIColor.black.cgColor
            cell!.layer.borderWidth = 1
            cell?.layer.cornerRadius  = 20
            cell!.clipsToBounds = true
        
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
           // vc?.iback = arrayOfDicTeams[indexPath.row]["strTeamFanart1"]!!
            vc?.dteam = arrayOfDicTeams[indexPath.row]["strDescriptionEN"]!!
            vc?.instagram = arrayOfDicTeams[indexPath.row]["strInstagram"]!!
            vc?.facebook = arrayOfDicTeams[indexPath.row]["strFacebook"]!!
            vc?.Twitter = arrayOfDicTeams[indexPath.row]["strTwitter"]!!
            self.present(vc!, animated: true, completion: nil)
        }
        
    }
    // MARK: UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView != LastEventsCollection{
//            return CGSize(width: 209.0, height: 200.0)
//        }
//        else
//        {
//            return CGSize(width: 400, height: 200.0)
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
}
