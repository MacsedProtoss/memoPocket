//
//  UI Util.swift
//  memoPocket
//
//  Created by Macsed on 2020/1/27.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit

extension UIImage{
    func reSetSize(Size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(Size)
        UIGraphicsBeginImageContextWithOptions(Size, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: Size.width, height: Size.height))
        let reSizeImage:UIImage? = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reSizeImage!
    }
}


func getColor(hexValue: UInt64) -> UIColor {
    let red = CGFloat(Double((hexValue & 0xFF0000)>>16)/255.0)
    let green = CGFloat(Double((hexValue & 0x00FF00)>>8)/255.0)
    let blue = CGFloat(Double(hexValue & 0x0000FF)/255.0)
    let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    return color
}

let screensize = UIScreen.main.bounds
