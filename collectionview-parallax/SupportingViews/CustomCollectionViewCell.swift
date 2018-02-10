//
//  CustomCollectionViewCell.swift
//  collectionview-parallax
//
//  Created by Ravi Joshi on 2/8/18.
//  Copyright © 2018 Ravi Joshi. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    public let imageView = UIImageView()
    
    private var verticalCenterConstraint:NSLayoutConstraint?
    
    class func reuseString() -> String {
        return "CustomCollectionViewCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.clipsToBounds = true
        imageView.backgroundColor = .green
        contentView.addSubview(imageView)
        
        let viewsDictionary = ["imageView": imageView]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imageView]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary))
        
        imageView.clipsToBounds = true
        
        self.verticalCenterConstraint = NSLayoutConstraint(item: imageView,
                                                           attribute: NSLayoutAttribute.centerY,
                                                           relatedBy: .equal,
                                                           toItem: self,
                                                           attribute: .centerY,
                                                           multiplier: 1.0,
                                                           constant: 0.0)
        
        let heightConstraint = NSLayoutConstraint(item: imageView,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1.0,
                                                           constant: frame.size.height + (2 * 30.0))
        
        if let constraint = self.verticalCenterConstraint {
            self.addConstraint(constraint)
            self.addConstraint(heightConstraint)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)        
        if let attributes = layoutAttributes as? CustomLayoutAttributes {
            self.verticalCenterConstraint?.constant = attributes.parallaxOffset.y
        }
    }
}
