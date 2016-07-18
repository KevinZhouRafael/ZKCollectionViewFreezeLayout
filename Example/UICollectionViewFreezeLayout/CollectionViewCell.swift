//
//  CollectionViewCell.swift
//  UICollectionViewFreezeLayout
//
//  Created by rafael on 7/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let IDENTIFIER = "COLLECTION_VIEW_CELL"
    
    @IBOutlet weak var contentLabel:UILabel!
    
    override func awakeFromNib() {
        
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 0.5
    }
    
    
    func updateData(model:Model){
        if model.x < FREEZE_COLUM &&  model.y < FREEZE_ROW{
            backgroundColor = UIColor.brownColor()
        }else if model.y < FREEZE_ROW{
            backgroundColor = UIColor.grayColor()
        }else if model.x < FREEZE_COLUM{
            backgroundColor = UIColor.darkGrayColor()
        }else{
            backgroundColor = UIColor.whiteColor()
        }
        
        contentLabel.text = "\(model.x),\(model.y)"
    }
    
}
