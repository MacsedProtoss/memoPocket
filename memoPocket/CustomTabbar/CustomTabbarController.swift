//
//  CustomTabbarController.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/14.
//  Copyright © 2019 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class CustomTabbarVC : UIViewController {
    var tabbar = CustomTabbarView()
    private var tabNum = 0
    
    convenience init(tabNum : Int,btnList:[String],btnSize:Dictionary<String,CGSize>,selectedIndex :Int){
        self.init()
        self.tabNum = tabNum
        tabbar = CustomTabbarView(tabNum: tabNum, btnList: btnList, btnSize: btnSize,selectedIndex : selectedIndex)
        
    }
    
    override func viewDidLoad() {
        view.addSubview(tabbar)
        tabbar.snp.makeConstraints{(make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        
        
    }
    
    
    
    
}

