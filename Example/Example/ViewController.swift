//
//  ViewController.swift
//  ZKCollectionViewFreezeLayout
//
//  Created by rafael zhou on 07/18/2016.
//  Copyright (c) 2016 rafael zhou. All rights reserved.
//

import UIKit
import ZKCollectionViewFreezeLayout


let FREEZE_COLUM = 3
let FREEZE_ROW = 2
class Model {
    
    var x:Int!
    var y:Int!
    
}

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,ZKCollectionViewFreezeLayoutDelegate {

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
        
        let layout = ZKCollectionViewFreezeLayout()
        layout.delegate = self
        layout.freezeColum = FREEZE_COLUM
        layout.freezeRow = FREEZE_ROW
        layout.itemSize = CGSize(width: 70, height: 70)
        
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = UIColor.white
        collectionView.bounces = false
        
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.section][indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.IDENTIFIER, for: indexPath) as! CollectionViewCell
        
        cell.updateData(model)
        
        return cell
    }
}

