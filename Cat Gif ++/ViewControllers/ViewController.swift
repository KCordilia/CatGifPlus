//
//  ViewController.swift
//  Cat Gif ++
//
//  Created by Karim Cordilia on 12/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class ViewController: UICollectionViewController {
    let cellIdentifier = "CatCell"
    var fetchedResultsController: NSFetchedResultsController<Cat>
    let context = CoreDataStack.shared.mainManagedObjectContext
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    required init?(coder aDecoder: NSCoder) {
        let fetchRequest: NSFetchRequest<Cat> = Cat.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchedResultsController = NSFetchedResultsController<Cat>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        let emptyCoreData = Cat.checkIfEmpty(in: context)
        print(emptyCoreData)
        if emptyCoreData {
            CatServerNetworking.loadCatData { cat in
                Cat.saveCats(cat)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
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
        let url = URL(string: cat.url)
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CatCell
            else { preconditionFailure("no cell") }
        cell.catImage.kf.setImage(with: url)
//        print(cat.favourite)
        return cell
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            guard
                let destinationController = segue.destination as? CatDetailViewController,
                let indexPaths = collectionView.indexPathsForSelectedItems
                else { assertionFailure("unexpected controller"); return}
            let cat = fetchedResultsController.object(at: IndexPath(row: indexPaths[0][1], section: 0))
            destinationController.catURL = cat.url
            destinationController.cat = cat
            destinationController.isFavourite = cat.favourite
        }
    }
}
