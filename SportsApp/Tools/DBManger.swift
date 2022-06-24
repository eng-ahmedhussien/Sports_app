//
//  DBManger.swift
//  SportsApp
//
//  Created by Ahmed Hussien on 23/11/1443 AH.
//

import Foundation
import CoreData

class DBManager{
    static let sharedInstance = DBManager()
     init(){}
}
extension DBManager{
    
    func addMovie(appDelegate: AppDelegate,id: String, name: String, sport: String, alternate: String,image: String,youtube: String){
        let managedContext = appDelegate.persistentContainer.viewContext

        //if there is an entity called "Movie" then a value returns otherwise, it would be nil
        if let entity = NSEntityDescription.entity(forEntityName: "CoreLeague", in: managedContext){

            let CoreLeague = NSManagedObject(entity: entity, insertInto: managedContext)
            CoreLeague.setValue(id, forKey: "id")
            CoreLeague.setValue(name, forKey: "name")
            CoreLeague.setValue(sport, forKey: "sport")
            CoreLeague.setValue(alternate, forKey: "alternate")
            CoreLeague.setValue(image, forKey: "image")
            CoreLeague.setValue(youtube, forKey: "youtube")
            do {
                try managedContext.save()
                print(" sucss add")
            }catch let error as NSError {
                print("Error in saving")
                print(error.localizedDescription)
            }
        }
    }

    func fetchData(appDelegate: AppDelegate) -> [CoreLeague]{

        var fetchedList : [CoreLeague] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreLeague")

//        let predicate = NSPredicate(format: "title == %@", "SpiderMan")
//        fetchRequest.predicate = predicate

        do{
            fetchedList = try managedContext.fetch(fetchRequest) as! [CoreLeague]
            print("sucss fetch")
        }catch let error as NSError {
            print("Error in saving")
            print(error.localizedDescription)
        }

        return fetchedList
    }

    func delete(CoreLeague:CoreLeague, appDelegate: AppDelegate){
    
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(CoreLeague)
        do{
            try managedContext.save()
           // delegate.deleteMovieAtIndexPath(indexPath: indexPath)
            print("deleted")
        }catch let error as NSError{
            print("Error in saving")
            print(error.localizedDescription)
        }

    }
}
