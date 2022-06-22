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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfFavorite.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell
        cell?.leaguename.text = arrayOfFavorite[indexPath.row].name

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
                self.present(vc!, animated: true, completion: nil);
                print("Internet Available")
            } else {
                self.creatAlert(title: "error connection ", message: "Internet Not Available")
                print("Internet Not Available")
            }
        }
        
        
        
        //navigationController?.pushViewController(vc!, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 
}
