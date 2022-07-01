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
        
        cell!.configureCell(imageSport: arrayOfSports[indexPath.row].strSportThumb, nameSport: arrayOfSports[indexPath.row].strSport)
        
        cell!.layer.borderColor = UIColor.black.cgColor
        cell!.layer.borderWidth = 1
        cell?.layer.cornerRadius  = 30
        return cell!
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SportLegsTable") as? LegsTable
        vc?.sportsName = arrayOfSports[indexPath.row].strSport
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let leftAndRightPaddings: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 2.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width) // You can change width and height here as pr your requirement
        
    }
}

