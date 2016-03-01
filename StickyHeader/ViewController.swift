//
//  ViewController.swift
//  StickyHeader
//
//  Created by Alberto Manuel Dieguez Fernandez on 1/3/16.
//  Copyright © 2016 AlbertoMDF. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let data:[String] = ["data 0","data 1","data 2","data 3","data 4","data 5","data 6","data 7","data 8","data 9","data 10","data 11","data 12"]
    
    var collection:UICollectionView?
    var customLayout:CustomLayout = CustomLayout()
    
    override func viewDidLoad() {
        self.collection  = UICollectionView(frame: CGRectZero, collectionViewLayout: customLayout)
        self.collection?.registerClass(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head")
        self.collection?.registerClass(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        self.collection?.delegate = self
        self.collection?.dataSource = self
        self.collection?.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(self.collection!)
    }
    
    //MARK: UICollectionViewDataSource & UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.width, 50)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.data.count
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "head", forIndexPath: indexPath) as! Header
            if indexPath.section % 2 == 0 {
                headerView.backgroundColor = UIColor.grayColor()
            }
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
            let cell:CollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionCell
            cell.setData(self.data[indexPath.section])
            return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.width/2)
    }
}


class Header: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class CollectionCell:UICollectionViewCell{
    
    let rateLabel:UILabel = {
        let text = UILabel()
        text.textAlignment = .Center
        text.textColor = UIColor.whiteColor()
        text.adjustsFontSizeToFitWidth = true
        return text
    }()
    
    convenience init(){
        self.init(frame: CGRectZero)
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    func setData(data:String){
        self.rateLabel.text = data
    }
    func setupUI() {
        contentView.addSubview(rateLabel)
        rateLabel.frame = contentView.frame
    }
}

