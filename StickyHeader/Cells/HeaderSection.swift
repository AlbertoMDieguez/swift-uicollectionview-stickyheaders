//
//  HeaderSection.swift
//  StickyHeader
//
//  Created by Alberto Manuel Dieguez Fernandez on 2/3/16.
//  Copyright © 2016 AlbertoMDF. All rights reserved.
//

import Foundation
import UIKit

class HeaderSection: UICollectionReusableView {
    
    var currentData:HeaderSectionVM? {
        didSet{
            setCurrentData()
        }
    }
    
    @IBOutlet var imageImg:UIImageView?
    @IBOutlet var animalTitle:UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setData(vm:HeaderSectionVM){
        self.currentData = vm
    }
    private func setCurrentData(){
        if let data = self.currentData{
            if let title = data.title{
                self.animalTitle?.text = title
            }
            if let img = data.image{
                self.imageImg?.image = UIImage(named: img)
            }
        }
    }
    
}