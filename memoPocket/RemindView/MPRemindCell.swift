//
//  RemindCell.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import SnapKit
import UIKit
class remindCell:UITableViewCell{
    let screensize = UIScreen.main.bounds
    var imageofcell:UIImageView?
    func getColor(hexValue: UInt64) -> UIColor {
        let red = CGFloat(Double((hexValue & 0xFF0000)>>16)/255.0)
        let green = CGFloat(Double((hexValue & 0x00FF00)>>8)/255.0)
        let blue = CGFloat(Double(hexValue & 0x0000FF)/255.0)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func initUI(){
        imageofcell = UIImageView(frame: CGRect(x: screensize.width*5/375, y: 0, width: screensize.width*365/375, height: screensize.height * 102/812))
       
        self.addSubview(imageofcell!)
        self.backgroundColor = UIColor.clear
    }
    
}

