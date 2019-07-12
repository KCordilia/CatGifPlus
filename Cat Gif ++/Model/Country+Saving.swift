//
//  Country+Saving.swift
//  POSTExample
//
//  Created by Daniel Salber on 7/9/19.
//  Copyright © 2019 mackey.nl. All rights reserved.
//

import Foundation
import CoreData

extension Cat {
    static func saveCats(_ serverCats: [ServerCat]) {
        let backgroundContext = CoreDataStack.shared.persistentContainer.newBackgroundContext()

        serverCats.forEach { serverCat in
            if Cat.cat(id: serverCat.id, in: backgroundContext) == nil {
                _ = Cat(from: serverCat, in: backgroundContext)
            }
        }
        CoreDataStack.shared.saveContext(backgroundContext)
    }
}
