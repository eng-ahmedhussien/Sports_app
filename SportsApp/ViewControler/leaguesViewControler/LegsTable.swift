//
//  SportLegsTable.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import UIKit

class LegsTable: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var leaguesTableView: UITableView!
    var arrayOfLeagues = [League]()
    var arrayOfLeaguesInSport = [League]()
    var sportsName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesTableView.delegate=self
        leaguesTableView.dataSource=self
        ScreenData()
        
        
    }

    func ScreenData(){
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
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfLeaguesInSport.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as? LeagueCell

        cell?.nameLeague.text = arrayOfLeaguesInSport[indexPath.row].strLeague

//        let url = URL(string:arrayOfLeagues[indexPath.row].str )
//        if let data = try? Data(contentsOf: url!) {
//        cell?.sportImage.image = UIImage(data: data)
//        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "teamsViewController") as? teamsViewController
        vc?.leagueId = arrayOfLeaguesInSport[indexPath.row].idLeague
        self.present(vc!, animated: true, completion: nil)
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
