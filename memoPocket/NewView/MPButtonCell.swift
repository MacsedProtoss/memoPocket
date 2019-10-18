//
//  ButtonCell.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import Foundation
import UIKit

class ButtonCell: RoundCell {

    override var top: Bool {
        get {
            return super.top
        }
        set {
            super.top = true
        }
    }

    override var bottom: Bool {
        get {
            return super.bottom
        }
        set {
            super.bottom = true
        }
    }

    override var frame: CGRect {
        get {
            return super.frame
        }

        set(newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.83
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            super.frame = frame
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel?.textColor = .white
        textLabel?.textAlignment = .center
        textLabel?.font = UIFont.systemFont(ofSize: 19, weight: .medium)

        layer.cornerRadius = 25
        layer.masksToBounds = true
    }
}

