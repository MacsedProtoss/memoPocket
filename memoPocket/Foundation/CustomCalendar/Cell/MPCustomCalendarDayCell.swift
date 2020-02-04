//
//  MPCustomCalendarDayCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/3.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomCalendarDayCell : UICollectionViewCell{
    
    var day : Int = 0
    var label : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(day : Int){
        self.init()
        self.day = day
        getView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getView(){
        label = UILabel()
        label.text = String(describing: day)
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangSC-Medium", size: 22.reSized)
        label.textColor = getColor(hexValue: 0x49506C, alpha: 0.8)
    }
}
