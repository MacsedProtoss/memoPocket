//
//  SegamentCell.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import Foundation
import UIKit
class segementCell: UITableViewCell {
    var imageAbove:UIImageView?
    var imageBelow:UIImageView?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageAbove = UIImageView()
        imageBelow = UIImageView()
        self.addSubview(imageAbove!)
        self.addSubview(imageBelow!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
