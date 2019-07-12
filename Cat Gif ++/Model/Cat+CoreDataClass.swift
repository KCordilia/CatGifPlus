//
//  Cat+CoreDataClass.swift
//  Cat Gif ++
//
//  Created by Karim Cordilia on 12/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//
//

import Foundation
import CoreData

public class Cat: NSManagedObject {
    convenience init(from serverCat: ServerCat, in context: NSManagedObjectContext) {
        self.init(context: context)
        id = serverCat.id
        url = serverCat.url
    }
}
