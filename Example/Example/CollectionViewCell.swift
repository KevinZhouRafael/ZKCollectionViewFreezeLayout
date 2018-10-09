//
//  CollectionViewCell.swift
//  ZKCollectionViewFreezeLayout
//
//  Created by rafael on 7/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let IDENTIFIER = "COLLECTION_VIEW_CELL"
    
    @IBOutlet weak var contentLabel:UILabel!
    
    override func awakeFromNib() {
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }
    
    
    func updateData(_ model:Model){
        if model.x < FREEZE_COLUM &&  model.y < FREEZE_ROW{
            backgroundColor = UIColor.brown
        }else if model.y < FREEZE_ROW{
            backgroundColor = UIColor.gray
        }else if model.x < FREEZE_COLUM{
            backgroundColor = UIColor.darkGray
        }else{
            backgroundColor = UIColor.white
        }
        
        contentLabel.text = "\(model.x!),\(model.y!)"
    }
    
}
