//
//  CollectionCategoryViewCell.swift
//  videoEditing
//
//  Created by macbook on 7/19/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class CollectionCategoryViewCells: UICollectionViewCell {
    
    var obj:MainCategory?

    @IBOutlet weak var imageView: UIImageView!
    public func configure(){
        if let object=obj{
            imageView.image = object.imageName
        
    }
    
    
    
}
}
