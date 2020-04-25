//
//  NSManagedObjectExtension.swift
//  cabin
//
//  Created by INNOVA BILISIM on 08/04/16.
//  Copyright © 2016 Innova. All rights reserved.
//

import Foundation
import CoreData


public extension NSManagedObject {
    
    class var entityName : String {
        let components = NSStringFromClass(self).components(separatedBy: ".")
        return components[1]
    }
    
    
    class func fetchCoreDataRequest() -> NSFetchRequest<NSManagedObject> {
        return NSFetchRequest<NSManagedObject>(entityName:self.entityName)
    }
    
    class func fetchRequestWithKey(_ key: String, ascending: Bool = true) -> NSFetchRequest<NSManagedObject> {
        let request = fetchCoreDataRequest()
        request.sortDescriptors = [NSSortDescriptor(key: key, ascending: ascending)]
        return request
    }
    
}
