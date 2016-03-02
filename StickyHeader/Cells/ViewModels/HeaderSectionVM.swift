//
//  HeaderSectionVM.swift
//  StickyHeader
//
//  Created by Alberto Manuel Dieguez Fernandez on 2/3/16.
//  Copyright © 2016 AlbertoMDF. All rights reserved.
//

import Foundation

class HeaderSectionVM{
    
    let image:String?
    let title:String?
    let subtitle:String?
    
    init(index:Int){
        image = "animal-\(index)"
        title = "Title animal \(index)"
        subtitle = "Subtitle animal \(index)"
    }
}
