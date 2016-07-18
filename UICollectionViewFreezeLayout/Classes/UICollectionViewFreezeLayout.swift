//
//  UICollectionViewFreezeLayout.swift
//  Waka
//
//  Created by rafael on 5/6/16.
//  Copyright © 2016 Waka. All rights reserved.
//

import UIKit

@objc public protocol UICollectionViewFreezeLayoutDelegate : UICollectionViewDelegate {
    
    @objc optional func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    
    @objc optional func contentSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGSize
    
}
@objc public class UICollectionViewFreezeLayout: UICollectionViewLayout {
    

    // default Size of the cell
    public var itemSize:CGSize = CGSize(width: 50, height: 50)
    
    
    private var cellAttrsDictionary = Dictionary<NSIndexPath, UICollectionViewLayoutAttributes>()
    private var cellAttrsDictionaryConst = Dictionary<NSIndexPath, UICollectionViewLayoutAttributes>() //初始化后，拖动也不会变的数据。用来保存初始布局。
    
    public var freezeColum:Int = 1
    public var freezeRow:Int = 1
    
    // Defines the size of the area the user can move around in
    // within the collection view.
     var contentSize = CGSize.zero
    
    // Used to determine if a data source update has occured.
    // Note: The data source would be responsible for updating
    // this value if an update was performed.
    var dataSourceDidUpdate = true
    
    public weak var delegate:UICollectionViewFreezeLayoutDelegate?
    
    override  public func collectionViewContentSize() -> CGSize {
        return self.contentSize
    }
    
    override public func prepareLayout() {
        
        // Only update header cells.
        if !dataSourceDidUpdate {
            
            // Determine current content offsets.
            let xOffset = collectionView!.contentOffset.x
            let yOffset = collectionView!.contentOffset.y
            
            if collectionView?.numberOfSections() > 0 {
                for section in 0...collectionView!.numberOfSections()-1 {
                    
                    if collectionView?.numberOfItemsInSection(section) > 0 {
                        
                        // Update all items with freeze
                        
                        for item in 0...collectionView!.numberOfItemsInSection(section)-1 {
                            
                            if section < freezeRow && item < freezeColum {
                                let indexPath = NSIndexPath(forItem: item, inSection: section)
                                if let attrs = cellAttrsDictionary[indexPath] {
                                    var frame = attrs.frame
                                    frame.origin.x = xOffset + cellAttrsDictionaryConst[indexPath]!.frame.origin.x
                                    frame.origin.y = yOffset + cellAttrsDictionaryConst[indexPath]!.frame.origin.y
                                    attrs.frame = frame
                                }
                                
                            }else if section < freezeRow {
                                // Build indexPath to get attributes from dictionary.
                                
                                let indexPath = NSIndexPath(forItem: item, inSection: section)
                                // Update y-position to follow user.
                                if let attrs = cellAttrsDictionary[indexPath] {
                                    var frame = attrs.frame
                                    
                                    frame.origin.y = yOffset + cellAttrsDictionaryConst[indexPath]!.frame.origin.y
                                    attrs.frame = frame
                                }
                                
                            }else if item < freezeColum {
                                // Build indexPath to get attributes from dictionary.
                                let indexPath = NSIndexPath(forItem: item, inSection: section)
                                
                                // Update x-position to follow user.
                                if let attrs = cellAttrsDictionary[indexPath] {
                                    var frame = attrs.frame
                                    frame.origin.x = xOffset + cellAttrsDictionaryConst[indexPath]!.frame.origin.x
                                    
                                    attrs.frame = frame
                                }
                                
                            }
                            
                        } //// Update all items with freeze
                        
                    }
                }
            }
            
            
            // Do not run attribute generation code
            // unless data source has been updated.
            updateContentSize()
            return
        }
        
        // Acknowledge data source change, and disable for next time.
        dataSourceDidUpdate = false
        
        // Cycle through each section of the data source.
        if collectionView?.numberOfSections() > 0 {
            for section in 0...collectionView!.numberOfSections()-1 {
                
                // Cycle through each item in the section.
                if collectionView?.numberOfItemsInSection(section) > 0 {
                    
                    var xPos:CGFloat = 0
                    var yPos:CGFloat = 0
                    
                    for item in 0...collectionView!.numberOfItemsInSection(section)-1 {
                        
                        // Build the UICollectionVieLayoutAttributes for the cell.
                        let cellIndex = NSIndexPath(forItem: item, inSection: section)
                        //                        let xPos = CGFloat(item) * getItemSize(cellIndex).width
                        //                        let yPos = CGFloat(section) * getItemSize(cellIndex).height
                        
                        
                        yPos =  CGFloat(section) * getItemSize(cellIndex).height
                        
                        
                        let cellAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: cellIndex)
                        cellAttributes.frame = CGRect(x: xPos, y: yPos, width: getItemSize(cellIndex).width, height: getItemSize(cellIndex).height)
                        
                        // Determine zIndex based on cell type.
                        if section < freezeRow && item < freezeColum {
                            cellAttributes.zIndex = 4
                        } else if section < freezeRow{
                            cellAttributes.zIndex = 3
                        } else if item < freezeColum {
                            cellAttributes.zIndex = 2
                        } else {
                            cellAttributes.zIndex = 1
                        }
                        
                        // Save the attributes.
                        cellAttrsDictionary[cellIndex] = cellAttributes
                        cellAttrsDictionaryConst[cellIndex] = cellAttributes.copy() as? UICollectionViewLayoutAttributes
                        
                        xPos += getItemSize(cellIndex).width
                    }
                }
                
            }
        }
        
        // Update content size.
        updateContentSize()
        
    }
    
    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // Create an array to hold all elements found in our current view.
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        // Check each element to see if it should be returned.
        for cellAttributes in cellAttrsDictionary.values {
            if CGRectIntersectsRect(rect, cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        
        // Return list of elements.
        return attributesInRect
    }
    
    override public func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttrsDictionary[indexPath]!
    }
    
    override public func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    
    
    func getItemSize(indexPath:NSIndexPath)->CGSize{
        if delegate != nil && (delegate!.respondsToSelector(#selector(UICollectionViewFreezeLayoutDelegate.collectionView(_:layout:sizeForItemAtIndexPath:)))) {
            return (delegate!.collectionView!(collectionView!, layout: self, sizeForItemAtIndexPath: indexPath))
        }else{
            return itemSize
        }
    }
    
    func updateContentSize(){
        
        if delegate != nil && (delegate!.respondsToSelector(#selector(UICollectionViewFreezeLayoutDelegate.contentSize(_:layout:)))) {
            self.contentSize = delegate!.contentSize!(collectionView!, layout: self)
        }else{
            let contentHeight = CGFloat(collectionView!.numberOfSections()) * itemSize.height
            
            var contentWidth:CGFloat = 0.0
            if collectionView!.numberOfSections() > 0 {
                contentWidth = CGFloat(collectionView!.numberOfItemsInSection(0)) * itemSize.width
            }
            
            self.contentSize = CGSize(width: contentWidth, height: contentHeight)
        }
        
    }
}
