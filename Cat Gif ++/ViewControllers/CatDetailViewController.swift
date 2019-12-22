//
//  CatDetailViewController.swift
//  Cat Gif ++
//
//  Created by Karim Cordilia on 12/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import UIKit
import Kingfisher

class CatDetailViewController: UIViewController {
    var catURL: String?
    var cat: Cat?
    var isFavourite: Bool?
    @IBOutlet weak var catImage: UIImageView!

    override func viewDidLoad() {
        guard
            let catURL = catURL
            else { return }
        let url = URL(string: catURL)
        catImage.kf.setImage(with: url)

    }
    @IBAction func longPressAction(_ sender: Any) {
        let alert = UIAlertController(title: "Add To Favourites", message: "Do you want to add this image to your favourites?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            guard
                let cat = self.cat,
                let catContext = self.cat?.managedObjectContext
                else { return }
            cat.favourite = true
            CoreDataStack.shared.saveContext(catContext)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            guard
                let cat = self.cat,
                let catContext = self.cat?.managedObjectContext
                else { return }
            cat.favourite = false
            CoreDataStack.shared.saveContext(catContext)
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
