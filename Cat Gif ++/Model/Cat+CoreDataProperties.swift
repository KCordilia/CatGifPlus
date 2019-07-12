//
//  Cat+CoreDataProperties.swift
//  Cat Gif ++
//
//  Created by Karim Cordilia on 12/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//
//

import Foundation
import CoreData


extension Cat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cat> {
        return NSFetchRequest<Cat>(entityName: "Cat")
    }

    @NSManaged public var id: String
    @NSManaged public var url: String

}
