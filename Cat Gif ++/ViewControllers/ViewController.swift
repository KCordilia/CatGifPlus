//
//  ViewController.swift
//  Cat Gif ++
//
//  Created by Karim Cordilia on 12/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UICollectionViewController {
    let cellIdentifier = "CatCell"
    var fetchedResultsController: NSFetchedResultsController<Cat>
    
    required init?(coder aDecoder: NSCoder) {
        let fetchRequest: NSFetchRequest<Cat> = Cat.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchedResultsController = NSFetchedResultsController<Cat>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            assert(false, error.localizedDescription)
        }
    }

}

extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionInfo: AnyObject = fetchedResultsController.sections?[section] {
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cat = fetchedResultsController.object(at: IndexPath(row: indexPath.row, section: 0))
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CatCell
            else { preconditionFailure("no cell") }
        return cell
    }
}

