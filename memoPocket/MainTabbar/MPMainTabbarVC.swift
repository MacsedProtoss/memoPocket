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
    
    var item: UIView? = nil
    
    let sizeDict : Dictionary<String,CGSize> = ["memoBtn":CGSize(width: 24, height: 36),"remindBtn":CGSize(width: 23, height: 42),"infoBtn":CGSize(width: 23, height: 38)]
    
    let btnList = ["memoBtn","remindBtn","infoBtn"]
    
    var tabbarVC = CustomTabbarVC()
    
    override func viewDidLayoutSubviews() {
        tabBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        let memoVC = UINavigationController(rootViewController: memoViewController())
        let infoVC = UINavigationController()
        let remindVC = UINavigationController(rootViewController: RemindVC())
        tabbarVC = CustomTabbarVC(tabNum: 3, btnList: btnList, btnSize: sizeDict,selectedIndex:2)
        
        for index in 1...tabbarVC.tabbar.numOfSection{
            tabbarVC.tabbar.sections[index-1].addTarget(self, action: #selector(handleTabPress(_:)), for: .touchUpInside)
            
        }
        
        let VCs = [memoVC,remindVC,infoVC]
        
        self.viewControllers = VCs
        tabBar.isHidden = true
        
        tabBar.isTranslucent = false
        
        self.addChild(tabbarVC)
        view.addSubview(tabbarVC.view)
        
        tabbarVC.view.snp.makeConstraints{(make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-21)
            make.height.equalTo(85)
        }
        
        self.selectedViewController = remindVC
    }
    
    
    @objc private func handleTabPress(_ sender : UIButton){
        print("tab pressed at \(sender.tag)")
        tabbarVC.tabbar.seletedIndex = sender.tag
        self.selectedViewController = self.viewControllers![sender.tag - 1]
        for btn in tabbarVC.tabbar.sections{
            if btn.tag != tabbarVC.tabbar.seletedIndex{
                btn.setImage(UIImage(named: tabbarVC.tabbar.btnList[btn.tag-1])!.reSetSize(Size: tabbarVC.tabbar.sizeDict[tabbarVC.tabbar.btnList[btn.tag-1]]!).withRenderingMode(.alwaysOriginal), for: .normal)
            }else{
                let imageName = tabbarVC.tabbar.btnList[btn.tag-1] + "Selected"
                btn.setImage(UIImage(named: imageName)!.reSetSize(Size: tabbarVC.tabbar.sizeDict[tabbarVC.tabbar.btnList[btn.tag-1]]!).withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
        
        
    }
    
    func dissmissConstraints(){
        tabbarVC.view.snp.updateConstraints{(make) in
            make.bottom.equalToSuperview().offset(300)
        }
    }
    
    func showConstraints(){
        tabbarVC.view.snp.updateConstraints{(make) in
            make.bottom.equalToSuperview().offset(-21)
        }
    }
    
}

