//
//  RoundCell.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import Foundation
import UIKit

class RoundCell: UITableViewCell {

    var top  = false
    var bottom = false

    override var frame: CGRect {
        get {
            return super.frame
        }

        set(newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.9
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space

            super.frame = frame
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // 修改字体
        textLabel?.textColor = UIColor(named: "text")
        

        // 修改圆角
        if top && bottom {
            layer.cornerRadius = 10
            layer.masksToBounds = true
            return
        } else if !top && !bottom {
            return
        }

        let shape = CAShapeLayer()
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.size.height)
        let corners: UIRectCorner = self.top ? [.topLeft, .topRight] : [.bottomRight, .bottomLeft]

        shape.path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 10, height: 10)).cgPath
        layer.mask = shape
        layer.masksToBounds = true
    }


}

