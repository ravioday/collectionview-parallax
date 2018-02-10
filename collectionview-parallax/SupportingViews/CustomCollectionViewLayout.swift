//
//  CustomCollectionViewLayout.swift
//  collectionview-parallax
//
//  Created by Ravi Joshi on 2/8/18.
//  Copyright © 2018 Ravi Joshi. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    let maxParallaxOffset:CGFloat = 30.0
    var attributesArray:[CustomLayoutAttributes] = []
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
        self.itemSize = CGSize(width: UIScreen.main.bounds.width - 20.0, height: 300.0)
        self.minimumLineSpacing = 20.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override class var layoutAttributesClass: AnyClass {
        return CustomLayoutAttributes.self
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func prepare() {
        if let collectionView = self.collectionView {
            let numberOfItems = collectionView.numberOfItems(inSection: 0)
            
            for i in stride(from: 0, to: numberOfItems, by: 1) {
                let indexPath = IndexPath(item: i, section: 0)
                let attribute = CustomLayoutAttributes(forCellWith: indexPath)                
                let yOrigin:CGFloat =  (self.itemSize.height + 20.0) * CGFloat(i)
                let frame = CGRect(x: 10.0, y: yOrigin, width: self.itemSize.width, height: self.itemSize.height)
                
                attribute.frame = frame
                attribute.parallaxOffset = self.calculateParallaxOffsetFor(attribute)
                attributesArray.append(attribute)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array =  attributesArray.filter { $0.frame.intersects(rect) }
        return array
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesArray[indexPath.item]
    }
    
    private func calculateParallaxOffsetFor(_ layoutAttributes:CustomLayoutAttributes) -> CGPoint {
        if let collectionView = self.collectionView {
            let currentBoundsCenter = CGPoint(x: collectionView.bounds.midX, y: collectionView.bounds.midY)
            
            let cellCenter = layoutAttributes.center
            let cellSize = layoutAttributes.size
            let offsetFromCenter = CGPoint(x: currentBoundsCenter.x - cellCenter.x, y: currentBoundsCenter.y - cellCenter.y)
            
            let maximumVerticalOffsetTillCellIsVisible = collectionView.bounds.height / 2.0 + cellSize.height / 2.0

            let scaleFactor = maxParallaxOffset / maximumVerticalOffsetTillCellIsVisible
            
            let parallaxOffsetPoint = CGPoint(x: 0.0, y: scaleFactor * offsetFromCenter.y)
            
            return parallaxOffsetPoint
        }
        return .zero
    }
}

