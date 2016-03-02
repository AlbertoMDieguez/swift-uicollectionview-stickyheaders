//
//  ViewController.swift
//  StickyHeader
//
//  Created by Alberto Manuel Dieguez Fernandez on 1/3/16.
//  Copyright © 2016 AlbertoMDF. All rights reserved.
//

import UIKit

enum StickyHeadersReusablesId:String {
    case HeaderSectionViewId = "headId"
    case HeaderSectionCellId = "cellId"
}

class ViewController: UIViewController {
    let cellSize:CGSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width/3)
    var sectionsCount:Int?
    var data:[HeaderSectionVM] = [] {
        didSet{
            sectionsCount = data.count
        }
    }
    var collection:UICollectionView?
    var customLayout:CustomLayout = CustomLayout()
    
    
    override func viewDidLoad() {
        
        //Get data to present
        self.data = self.generateCollectionData()
        //Init collection view with custom layout
        self.collection  = UICollectionView(frame: CGRectZero, collectionViewLayout: customLayout)
        //Set delegates
        self.collection?.delegate = self
        self.collection?.dataSource = self
        //Set collection frame
        self.collection?.frame = UIScreen.mainScreen().bounds
        //Add collection to UIController
        self.view.addSubview(self.collection!)
        //Register cells & supplementary view on collection
        registerCells()
        
    }

    func registerCells(){
        self.collection?.registerNib(
            UINib.init(nibName: "HeaderSectionView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: StickyHeadersReusablesId.HeaderSectionViewId.rawValue)
        self.collection?.registerClass(CollectionCell.self, forCellWithReuseIdentifier: StickyHeadersReusablesId.HeaderSectionCellId.rawValue)
    }
    
    func generateCollectionData()->[HeaderSectionVM]{
        var auxData:[HeaderSectionVM] = []
        for index in 0...26 {
            auxData.append(HeaderSectionVM(index: index))
        }
        return auxData
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    // Section Header Size
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
            
        return CGSizeMake(UIScreen.mainScreen().bounds.width, collectionView.frame.width/5)
    }
    
    // Sections count
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    
    // Supplementary view
    func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: StickyHeadersReusablesId.HeaderSectionViewId.rawValue, forIndexPath: indexPath) as! HeaderSection
            
            headerView.setData(self.data[indexPath.section])
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    //Items in section count
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 1
    }
    
    //Cell for item at index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell:CollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(StickyHeadersReusablesId.HeaderSectionCellId.rawValue, forIndexPath: indexPath) as! CollectionCell
        
        cell.setData(self.data[indexPath.section])
        
        return cell
    }
    
    //Size for item at index path
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        return self.cellSize
    }
}



