//
//  MemoCell.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import Foundation
import UIKit
class memoCell:UITableViewCell{
    let screensize = UIScreen.main.bounds
    var imageofcell:UIImageView?
    var lineabove:UIImageView?
    var linebelow:UIImageView?
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
        imageofcell = UIImageView()
        lineabove = UIImageView()
        linebelow = UIImageView()
        
        self.addSubview(imageofcell!)
        self.addSubview(lineabove!)
        self.addSubview(linebelow!)
        self.backgroundColor = getColor(hexValue: 0xEDEFF4)
    }
    
}

