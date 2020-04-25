//
//  NSManagedObjectExtension.swift
//  cabin
//
//  Created by INNOVA BILISIM on 08/04/16.
//  Copyright © 2016 Innova. All rights reserved.
//

import Foundation
import CoreData


public extension NSManagedObjectContext {
    
 
   func insert<T : NSManagedObject>(_ entity: T.Type) -> T {
        let entityName = entity.entityName
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into:self) as! T
    }
    
    func fetchAll<T : NSManagedObject>(_ entity: T.Type, key:String? = nil, ascending:Bool = true) -> [T] {
        let fetchRequest : NSFetchRequest<T> = {
            if let key = key {
                return entity.fetchRequestWithKey(key, ascending: ascending) as! NSFetchRequest<T>
            } else {
                return entity.fetchCoreDataRequest() as! NSFetchRequest<T>
            }
        }()

        do {
            let results = try fetch(fetchRequest)
            return results
        }
        catch{
            print("No " + NSStringFromClass(T.self) + "found in DB")
        }
    
        return [T]()
    }
    
}
