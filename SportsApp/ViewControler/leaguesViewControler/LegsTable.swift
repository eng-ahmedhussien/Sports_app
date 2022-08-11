//
//  SportLegsTable.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import UIKit
import NVActivityIndicatorView
class LegsTable: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var leaguesTableView: UITableView!
    var arrayOfLeagues = [League]()
    var arrayOfLeaguesInSport = [League]()
    var arrayOfLeaguesBySport = [Leagu]()
    var sportsName = ""
    @IBOutlet weak var indecatore: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesTableView.delegate=self
        leaguesTableView.dataSource=self
        ScreenData1()
        loadindecatore()
        //leaguesTableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "LeagueCell")
        leaguesTableView.registerCellNib(cellClass: LeagueCell.self)
        
    }
    func ScreenData1(){
        let sportsNameArray = sportsName.split(separator: " ")
        var newsportsName = ""
        for i in 0..<sportsNameArray.count{
            if i == sportsNameArray.count-1{
                newsportsName += "\(sportsNameArray[i])"
            }
            else{
                newsportsName += "\(sportsNameArray[i])%20"
            }
        }
        
        
        let ViewModel =  AllLeagusBySport()
        ViewModel.fetchData(url:"\(URLs.allLeaguesBySport)\(newsportsName)")
       // print("\(URLs.allLeaguesBySport)\(sportsName)")
        ViewModel.updateData = { allLeague , error in
            if let allLeague = allLeague {
                self.arrayOfLeaguesBySport  = allLeague
                self.leaguesTableView.reloadData()
                self.indecatore.stopAnimating()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func ScreenData2(){
        let ViewModel =  AllLeagusViewModel()
        ViewModel.fetchData(url:URLs.allLeaguesurl)
        ViewModel.updateData = { allLeague , error in
            if let allLeague = allLeague {
                self.arrayOfLeagues = allLeague
                for i in self.arrayOfLeagues{
                    if i.strSport == self.sportsName{

                        self.arrayOfLeaguesInSport.append(i)
                    }
                }
                self.leaguesTableView.reloadData()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadindecatore(){
        indecatore.color =  .orange
        indecatore.type = .ballPulseSync
        indecatore.padding = 150
        indecatore.startAnimating()
        }
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfLeaguesBySport.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as? LeagueCell
         //let cell = tableView.dequeue() as? LeagueCell
         cell?.nameLeague.text = arrayOfLeaguesBySport[indexPath.row].strLeague
         let url = URL(string:arrayOfLeaguesBySport[indexPath.row].strBadge )
         if let data = try? Data(contentsOf: url!) {
             cell?.imageLeague.image = UIImage(data: data)
         }
         cell?.youtube = arrayOfLeaguesBySport[indexPath.row].strYoutube
         
         
         // add border and color
         cell!.layer.borderColor = UIColor.black.cgColor
         cell!.layer.borderWidth = 1
         cell?.layer.cornerRadius  = 10
         cell!.clipsToBounds = true
       //  cell?.contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
         //cell?.imageLeague.layer.cornerRadius = (cell?.imageLeague.frame.height)!/2
         return cell!
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "TeamsView", bundle: nil).instantiateViewController(withIdentifier: "teamsViewController") as? teamsViewController
        vc?.leaguename = arrayOfLeaguesBySport[indexPath.row].strLeague
        vc?.leagueId = arrayOfLeaguesBySport[indexPath.row].idLeague
        vc?.sportName = arrayOfLeaguesBySport[indexPath.row].strSport
        self.present(vc!, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "leagues"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .center
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
   
//    func tableView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        }
}
