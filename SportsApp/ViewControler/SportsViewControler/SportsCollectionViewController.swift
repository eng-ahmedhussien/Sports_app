//
//  SportsCollectionViewController.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 21/11/1443 AH.
//

import UIKit

private let reuseIdentifier = "Cell"

class SportsCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var arrayOfSports = [Sport]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ScreenData()
    }

    func ScreenData(){
        let ViewModel =  SportsViewModel()
        ViewModel.fetchData(url:URLs.allSports)
        ViewModel.updateData = { sports , error in
            if let sports = sports {
                self.arrayOfSports = sports
                print(self.arrayOfSports.count)
                self.collectionView.reloadData()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfSports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as? SportCell
        cell!.sportName.text = arrayOfSports[indexPath.row].strSport
        let url = URL(string:arrayOfSports[indexPath.row].strSportThumb)
        if let data = try? Data(contentsOf: url!) {
            cell?.sportImage.image = UIImage(data: data)
        }
        cell!.layer.borderColor = UIColor.black.cgColor
        cell!.layer.borderWidth = 1
        cell?.layer.cornerRadius  = 20
        cell!.clipsToBounds = true
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SportLegsTable") as? LegsTable
        vc?.sportsName = arrayOfSports[indexPath.row].strSport
        navigationController?.pushViewController(vc!, animated: true)
    }
   
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5)
//    }
}

