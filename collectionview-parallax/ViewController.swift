//
//  ViewController.swift
//  collectionview-parallax
//
//  Created by Ravi Joshi on 2/8/18.
//  Copyright © 2018 Ravi Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    var images:[UIImage] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseString(), for: indexPath) as? CustomCollectionViewCell {
            cell.imageView.image = self.images[indexPath.row]
            cell.backgroundColor = .purple
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionView = UICollectionView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CustomCollectionViewLayout())
        collectionView.backgroundColor  = .orange
        collectionView.dataSource = self
    
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseString())
        images = setUpDataStructures()
        self.view.addSubview(collectionView)
    }
    
    private func setUpDataStructures() -> [UIImage]  {
        var images: [UIImage] = []
        
        for i in stride(from: 1, to: 8, by: 1) {
            let imageName = "image\(i)"
            if let image = UIImage(named: imageName) {
                images.append(image)
            }
        }
        
        return images
    }
}

