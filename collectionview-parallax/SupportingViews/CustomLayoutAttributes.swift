//
//  CustomLayoutAttributes.swift
//  collectionview-parallax
//
//  Created by Ravi Joshi on 2/8/18.
//  Copyright © 2018 Ravi Joshi. All rights reserved.
//

import UIKit

class CustomLayoutAttributes: UICollectionViewLayoutAttributes {
    var parallaxOffset: CGPoint = .zero
    
    // Layout Attributes objects are copied by the collection view and they implicitly conform to NSCopying protocol, so if we subclass layout aattributes to provide custom behavior we are expected to provide implementation for the following functions. 
    
    override func copy(with zone: NSZone? = nil) -> Any {
        if let copy = super.copy(with: zone) as? CustomLayoutAttributes {
            copy.parallaxOffset = self.parallaxOffset
            return copy
        }
        
        return CustomLayoutAttributes()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let objectToCompare = object as? CustomLayoutAttributes else { return false }
        
        if (!__CGPointEqualToPoint(self.parallaxOffset, objectToCompare.parallaxOffset)){
            return false
        }
        
        return super.isEqual(objectToCompare)
    }
}
