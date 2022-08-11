//
//  teamsViewController.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 22/11/1443 AH.
//

import UIKit
import CoreData
import NVActivityIndicatorView
import FirebaseFirestore



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
    let dbb = Firestore.firestore()
    
    @IBOutlet weak var Indecatore3: NVActivityIndicatorView!
    @IBOutlet weak var Indecatore2: NVActivityIndicatorView!
    @IBOutlet weak var indecatore: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadindecatore()
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
    func loadindecatore(){
        indecatore.color =  .orange
        indecatore.type = .ballPulseSync
        indecatore.padding = 150
        indecatore.startAnimating()
        Indecatore2.color =  .orange
        Indecatore2.type = .ballPulseSync
        Indecatore2.padding = 150
        Indecatore2.startAnimating()
        Indecatore3.color =  .orange
        Indecatore3.type = .ballPulseSync
        Indecatore3.padding = 150
        Indecatore3.startAnimating()
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
                leagueName += "\(leagueNameArray[i])_"
            }
        }
        ViewModel.fetchData(url:"\(URLs.allTeamsInLeague)\(leagueName)")
        print("\(URLs.allTeamsInLeague)\(leagueName)")
        ViewModel.updateData = { teams , error in
            if let teams = teams {
                self.arrayOfDicTeams = teams
                self.teamsCollection.reloadData()
                self.indecatore.stopAnimating()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
//        let ViewModel = TeamsViewModel()
//                ViewModel.fetchData(url:"\(URLs.allTeamsInLeague)\(leagueId)")
//                print("\(URLs.allTeamsInLeague)\(leagueId)")
//                ViewModel.updateData = { teams , error in
//                    if let teams = teams {
//                        self.arrayOfTeams = teams
//                        self.teamsCollection.reloadData()
//                    }
//                    if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
    }
    
    //MARK: upcomingScreenData
    func upcomingScreenData(){
        let ViewModel = UpcomingEventViewModel()
        ViewModel.fetchData(url:"\(URLs.upcomingUrl)\(leagueId)")
       // print("\(URLs.upcomingUrl)\(leagueId)")
        ViewModel.updateData = { events , error in
            if let events = events {
                self.arrayOfEvents = events
                self.UpcomingEventsCollection.reloadData()
                self.Indecatore2.stopAnimating()
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
                 self.Indecatore3.stopAnimating()
             }
             if let error = error {
                 print(error.localizedDescription)
             }
         }
    }
    
    //MARK: checkIfExistInCoreData
    func checkIfExistInCoreData()->Bool{
        arrayOfLeaguesCore =  try! context.fetch(CoreLeague.fetchRequest()) //db.fetchData(appDelegate: appDelegate)
        for j in self.arrayOfLeaguesCore{
            if j.id == leagueId{
                deleteFromFireBase(leagueId:leagueId)
                db.delete(CoreLeague: j, appDelegate: appDelegate)
                createAlart(title: "sccuess", message: "league removed from favorite")
                return true
            }
        }
        return false
    }
    func deleteFromFireBase(leagueId:String){
        dbb.collection("leaguse").whereField("id", isEqualTo: leagueId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.dbb.collection("leaguse").document(document.documentID).delete() { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                print("Document successfully removed!")
                            }
                        }
                        
                    }
                }
        }
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
        
        let sportsNameArray = sportName.split(separator: " ")
        var newsportsName = ""
        for i in 0..<sportsNameArray.count{
            if i == sportsNameArray.count-1{
                newsportsName += "\(sportsNameArray[i])"
            }
            else{
                newsportsName += "\(sportsNameArray[i])%20"
            }
        }
        let ViewModel = AllLeagusBySport()
        ViewModel.fetchData(url:"\(URLs.allLeaguesBySport)\(newsportsName)")
        ViewModel.updateData = { leagues , error in
            if let leagues = leagues {
                if  self.checkIfExistInCoreData() == false{
                    self.arrayOfLeagues = leagues
                    for i in self.arrayOfLeagues{
                        if i.idLeague == self.leagueId{
                            self.addDataToFirebase(leagu: i)
                            self.db.addLeague(appDelegate: self.appDelegate, id: i.idLeague, name: i.strLeague, sport: i.strSport, alternate: i.strLeagueAlternate!,image: i.strBadge,youtube: i.strYoutube)
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
        
    }
    func addDataToFirebase(leagu:Leagu){
        dbb.collection("leaguse").addDocument(data: [
           "id": leagu.idLeague,
           "name": leagu.strLeague,
           "sportsname":leagu.strSport,
           "image": leagu.strBadge,
           "LeagueAlternate": leagu.strLeagueAlternate
       ])
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
           // print("in teamsCollection")
             return arrayOfDicTeams.count
            
        }
        else if collectionView == self.UpcomingEventsCollection{
           // print("in UpcomingEventsCollection")
            return arrayOfEvents.count
        }
        else{
           // print("in lastEventsCollection")
            return arrayOfLastEvents.count
        }
      
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.teamsCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCell
            cell?.nameTeam.text = arrayOfDicTeams[indexPath.row]["strTeam"] as? String
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

            let vc = TeamsDeatilsViewController()
            vc.teamName = arrayOfDicTeams[indexPath.row]["strTeam"]!!
            vc.leagueName = arrayOfDicTeams[indexPath.row]["strLeague"]!!
            if let s = arrayOfDicTeams[indexPath.row]["strStadium"]{
                vc.stadiumName = s ?? "no stadium"
            }
            vc.teamImage = arrayOfDicTeams[indexPath.row]["strTeamBadge"]!!
            if let  descriptionTeam = arrayOfDicTeams[indexPath.row]["strDescriptionEN"]{
                vc.descriptionTeam = descriptionTeam ?? " no descriptionTeam"
            }
            if let instagram = arrayOfDicTeams[indexPath.row]["strInstagram"]{
                vc.instagram = instagram ?? "not instagram"
            }

            if let facebook =  arrayOfDicTeams[indexPath.row]["strFacebook"]{
                vc.facebook = facebook ?? "no facebook"
            }
            if let Twitter  = arrayOfDicTeams[indexPath.row]["strTwitter"]{
                vc.Twitter  = Twitter ?? "no Twitter"
            }
           self.present(vc, animated: true, completion: nil)
        }
        
    }

}
