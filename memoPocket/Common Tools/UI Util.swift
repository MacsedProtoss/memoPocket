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


extension UIView{
    
    func setCorner(byRoundingCorners corners: UIRectCorner,withBounds bounds:CGRect, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func setHalfCorneredRect(withBounds bounds:CGRect, radius: CGFloat){
        let maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x: bounds.width, y: 0))
        maskPath.addArc(withCenter: CGPoint(x: bounds.width, y: radius), radius: radius, startAngle: CGFloat(3/2*Double.pi), endAngle: CGFloat(Double.pi), clockwise: false)
        maskPath.addLine(to: CGPoint(x: 0, y: bounds.height - radius))
        maskPath.addArc(withCenter: CGPoint(x: bounds.width, y: bounds.height - radius), radius: radius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(1/2*Double.pi), clockwise: false)
        maskPath.addLine(to: CGPoint(x: bounds.width, y: 0))
        maskPath.close()
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
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
