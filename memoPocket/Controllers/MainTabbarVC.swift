//
//  MainTabbarVC.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import UIKit

import Foundation
import UIKit
class tabbarVC : UITabBarController{
    let screensize = UIScreen.main.bounds
    override func viewDidLayoutSubviews() {
        let tabbarVC = self
        var tabframe = tabbarVC.tabBar.frame
        print("tab origin frame is \(tabframe.size) \(tabframe.origin)")
        tabframe.size.height = 85//和图片保持一个高度 85

        tabframe.origin.y -= 21//这个是有底部导航栏情况下的偏移
        print("tab now frame is \(tabframe)")
        self.tabBar.frame = tabframe
        self.tabBar.backgroundColor = UIColor.red
        print(self.tabBar.subviews[0])
        
    }
    func getColor(hexValue: UInt64) -> UIColor {
        let red = CGFloat(Double((hexValue & 0xFF0000)>>16)/255.0)
        let green = CGFloat(Double((hexValue & 0x00FF00)>>8)/255.0)
        let blue = CGFloat(Double(hexValue & 0x0000FF)/255.0)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        let memoVC = UINavigationController(rootViewController: memoViewController())
        let infoVC = UINavigationController()
        let remindVC = UINavigationController(rootViewController: remindViewController())
        
        
        self.tabBar.backgroundImage = UIImage(named: "图层 3")?.reSetSize(Size: CGSize(width: screensize.size.width, height: 85))

//        self.tabBar.shadowImage =
        

        

        self.tabBar.clipsToBounds = true
       
        //一系列复杂测试之后发现起始值为48,别问我咋测试出来的
        //该值仅限含有bar的刘海机型（11 11Pro 11ProMax通用，理论上XR XS XSMAX也是一样的）
        //
        
        
            
        memoVC.tabBarItem.image = UIImage(named: "图层 5")?.reSetSize(Size: CGSize(width: 24/375*screensize.width, height: 36/812*screensize.height)).withRenderingMode(.alwaysOriginal)
        memoVC.tabBarItem.selectedImage = UIImage(named: "21")?.reSetSize(Size: CGSize(width: 24/375*screensize.width, height: 36/812*screensize.height)).withRenderingMode(.alwaysOriginal)
        
        
        
//        memoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 48-36, left: 0, bottom: 36-48, right: 0)
        

        infoVC.tabBarItem.image = UIImage(named: "图层 6")?.reSetSize(Size: CGSize(width: 23/375*screensize.width, height: 38/812*screensize.height)).withRenderingMode(.alwaysOriginal)
//        infoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 11, left: 0, bottom: -11, right: 0)
//        infoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 48-36-(38-36)/2, left: 0, bottom: 36-48+(38-36)/2, right: 0)

        remindVC.tabBarItem.selectedImage = UIImage(named: "图层 4")?.reSetSize(Size: CGSize(width: 23/375*screensize.width, height: 42/812*screensize.height)).withRenderingMode(.alwaysOriginal)
        remindVC.tabBarItem.image = UIImage(named: "22")?.reSetSize(Size: CGSize(width: 23/375*screensize.width, height: 42/812*screensize.height)).withRenderingMode(.alwaysOriginal)
//        remindVC.tabBarItem.imageInsets = UIEdgeInsets(top: 48-36-(42-36)/2, left: 0, bottom: 36-48+(42-36)/2, right: 0)
        
        

        let VCs = [memoVC,remindVC,infoVC]
        self.viewControllers = VCs
        
        
//        print("tabbar item height is \(self.tabBar.subviews[1].frame)")
//        print("tabbar item height is \(self.tabBar.subviews[2].frame)")
        
        
        self.selectedViewController = remindVC
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    
}

