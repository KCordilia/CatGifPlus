//
//  Country+Queries.swift
//  POSTExample
//
//  Created by Daniel Salber on 7/9/19.
//  Copyright © 2019 mackey.nl. All rights reserved.
//

import Foundation
import CoreData

extension Cat {
    static func checkIfEmpty(in context: NSManagedObjectContext) -> Bool {
        do{
            let request = NSFetchRequest<Cat>(entityName: "Cat")
            let count  = try context.count(for: request)
            return count == 0
        }catch{
            return true
        }
    }
    
    static func cat(id: String, in context: NSManagedObjectContext) -> Cat? {
        let predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        let request: NSFetchRequest<Cat> = Cat.fetchRequest()
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            return result.first
        } catch let error {
            assert(false, error.localizedDescription)
            return nil
        }
    }
}
