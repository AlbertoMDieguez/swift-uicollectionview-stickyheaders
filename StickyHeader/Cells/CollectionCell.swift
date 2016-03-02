//
//  CollectionCell.swift
//  StickyHeader
//
//  Created by Alberto Manuel Dieguez Fernandez on 2/3/16.
//  Copyright © 2016 AlbertoMDF. All rights reserved.
//

import Foundation
import UIKit

class CollectionCell:UICollectionViewCell{
    var currentData:HeaderSectionVM? {
        didSet{
            setCurrentData()
        }
    }
    let animalImage:UIImageView = UIImageView()
    
    let collectionLabel:UILabel = {
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
    func setData(data:HeaderSectionVM){
        self.currentData = data
    }
    func setupUI() {
        contentView.addSubview(collectionLabel)
        contentView.addSubview(animalImage)
        animalImage.frame = CGRectMake(UIScreen.mainScreen().bounds.width/2, 0, UIScreen.mainScreen().bounds.width/2, UIScreen.mainScreen().bounds.width/2)
        collectionLabel.frame = contentView.frame
    }
    private func setCurrentData(){
        if let data = self.currentData{
            if let img = data.image{
                self.animalImage.image = UIImage(named: "\(img)-white")
            }
        }
    }
    
}
