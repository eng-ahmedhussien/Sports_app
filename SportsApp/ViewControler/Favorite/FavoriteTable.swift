//
//  FavoriteTable.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 23/11/1443 AH.
//

import UIKit
import Alamofire
class FavoriteTable: UITableViewController {

    let reachabilityManager = NetworkReachabilityManager()
    var db1 = DBManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrayOfFavorite = [CoreLeague]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfFavorite  =  db1.fetchData(appDelegate: appDelegate)
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        arrayOfFavorite  = db1.fetchData(appDelegate: appDelegate)
        tableView.reloadData()
    }
    func checkNetwork(){
        reachabilityManager?.startListening()
        reachabilityManager?.listener = { _ in
            if let isNetworkReachable = self.reachabilityManager?.isReachable,
               isNetworkReachable == true {
                self.arrayOfFavorite  = self.db1.fetchData(appDelegate: self.appDelegate)
                self.tableView.reloadData()
                print("Internet Available")
            } else {
                self.creatAlert(title: "error connection ", message: "Internet Not Available")
                print("Internet Not Available")
            }
        }
    }
    func creatAlert (title:String,message:String){
           let alart = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
           alart.addAction(okButton)
           present(alart, animated: true, completion: nil)
         
       }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFavorite.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell
        cell?.leaguename.text = arrayOfFavorite[indexPath.row].name
        cell?.youtube = arrayOfFavorite[indexPath.row].youtube!
        
        let url = URL(string: arrayOfFavorite[indexPath.row].image!)!
        if let data = try? Data(contentsOf: url) {
            cell!.leagueimage.image = UIImage(data: data)
        }
        cell!.layer.borderColor = UIColor.black.cgColor
        cell!.layer.borderWidth = 1
        cell?.layer.cornerRadius  = 20
        cell!.clipsToBounds = true
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "teamsViewController") as? teamsViewController
        reachabilityManager?.startListening()
        reachabilityManager?.listener = { _ in
            if let isNetworkReachable = self.reachabilityManager?.isReachable,
               isNetworkReachable == true {
                vc?.leaguename = self.arrayOfFavorite[indexPath.row].name!
                vc?.leagueId  = self.arrayOfFavorite[indexPath.row].id!
                vc?.sportName = self.arrayOfFavorite[indexPath.row].sport!
                self.present(vc!, animated: true, completion: nil);
                print("Internet Available")
            } else {
                self.creatAlert(title: "error connection ", message: "Internet Not Available")
                print("Internet Not Available")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorite"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
        
    }
 
}
