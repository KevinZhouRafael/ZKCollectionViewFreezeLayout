//
//  ViewController.swift
//  UICollectionViewFreezeLayout
//
//  Created by rafael zhou on 07/18/2016.
//  Copyright (c) 2016 rafael zhou. All rights reserved.
//

import UIKit
import UICollectionViewFreezeLayout


let FREEZE_COLUM = 3
let FREEZE_ROW = 2
class Model {
    
    var x:Int!
    var y:Int!
    
}

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewFreezeLayoutDelegate {

    var models:[[Model]] = [[Model]]()
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var model:Model?
        for i in 0 ..< 30 {
            var modelArray = [Model]()
            
            for j in 0 ..< 15 {
                
                model = Model()
                model?.x = j
                model?.y = i
                modelArray.append(model!)
            }
            
            models.append(modelArray)
        }
        
        let layout = UICollectionViewFreezeLayout()
        layout.delegate = self
        layout.freezeColum = FREEZE_COLUM
        layout.freezeRow = FREEZE_ROW
        layout.itemSize = CGSize(width: 70, height: 70)
        
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.bounces = false
        
    }

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return models.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let model = models[indexPath.section][indexPath.item]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewCell.IDENTIFIER, forIndexPath: indexPath) as! CollectionViewCell
        
        cell.updateData(model)
        
        return cell
    }
}

