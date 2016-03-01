//
//  CustomLayout.swift
//  StickyHeader
//
//  Created by Alberto Manuel Dieguez Fernandez on 1/3/16.
//  Copyright © 2016 AlbertoMDF. All rights reserved.
//

import Foundation
import UIKit

class CustomLayout:UICollectionViewFlowLayout {
    
        override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            
            let superAttributes:NSMutableArray = NSMutableArray(array: super.layoutAttributesForElementsInRect(rect)!) as NSMutableArray
            
            let contentOffset = collectionView!.contentOffset
            let missingSections = NSMutableIndexSet()
            
            for layoutAttributes in superAttributes {
                if (layoutAttributes.representedElementCategory == .Cell) {
                    if let _ = layoutAttributes.indexPath {
                        missingSections.addIndex(layoutAttributes.indexPath.section)
                    }
                }
            }
            
            for layoutAttributes in superAttributes{
                if let representedElementKind = layoutAttributes.representedElementKind {
                    if representedElementKind == UICollectionElementKindSectionHeader {
                        if let indexPath = layoutAttributes.indexPath {
                            missingSections.removeIndex(indexPath.section)
                        }
                    }
                }
            }
            
            missingSections.enumerateIndexesUsingBlock { idx, stop in
                let indexPath = NSIndexPath(forItem: 0, inSection: idx)
                let layoutAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath)
                superAttributes.addObject(layoutAttributes!)
            }
            
            for la in superAttributes {
                
                let layoutAttributes = la as! UICollectionViewLayoutAttributes;
                
                if let representedElementKind = layoutAttributes.representedElementKind {
                    if representedElementKind == UICollectionElementKindSectionHeader {
                        let section = layoutAttributes.indexPath.section
                        
                        let firstCellIndexPath = NSIndexPath(forItem: 0, inSection: section)
                        
                        var firstCellAttributes:UICollectionViewLayoutAttributes
                        
                        if (self.collectionView!.numberOfItemsInSection(section) > 0) {
                            firstCellAttributes = self.layoutAttributesForItemAtIndexPath(firstCellIndexPath)!
                        } else {
                            firstCellAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: firstCellIndexPath)!
  
                        }
                        
                        let headerHeight = CGRectGetHeight(layoutAttributes.frame)
                        var origin = layoutAttributes.frame.origin
                        
                        origin.y = min(max(contentOffset.y, (CGRectGetMinY(firstCellAttributes.frame) - headerHeight)), (CGRectGetMaxY(firstCellAttributes.frame) - headerHeight))
                        ;
                        
                        
                        layoutAttributes.zIndex = 1024;
                        layoutAttributes.frame = CGRect(origin: origin, size: layoutAttributes.frame.size)
                        
                    }
                }
            }
            
            return NSArray(array: superAttributes) as? [UICollectionViewLayoutAttributes]
        }
        
        override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
            return true
        }
        
}