//
//  MainDynamicTabVC.swift
//  memoPocket
//
//  Created by Macsed on 2020/1/27.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit


class MainDynamicTabVC : UIViewController,UITableViewDelegate{
    
    var scrollStatus : scrollDirection = .up
    
    private let animationGroup = DispatchGroup.init()
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        
        if !decelerate{
            callBarUp()
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        callBarUp()
    }
    
    private func callBarUp(){
        animationGroup.notify(queue: DispatchQueue.main){
            if self.scrollStatus == .down {
                self.scrollStatus = .processing
                rootTabbarVC!.showConstraints()
                rootTabbarVC!.tabbarVC.tabbar.show()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    self.scrollStatus = .up
                    print("after drag back up done")
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let recognizer = scrollView.panGestureRecognizer
        let offsetY = recognizer.translation(in: scrollView).y
        if offsetY > 0 && scrollStatus == .down{
            print("Dragging up process")
            scrollStatus = .processing
            rootTabbarVC!.showConstraints()
            rootTabbarVC!.tabbarVC.tabbar.show()
            animationGroup.enter()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.scrollStatus = .up
                print("Dragging up done")
                self.animationGroup.leave()
            }
        }else if offsetY < 0 && scrollStatus == .up{
            print("Dragging down process")
            scrollStatus = .processing
            rootTabbarVC!.tabbarVC.tabbar.dissmiss()
            animationGroup.enter()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                rootTabbarVC!.dissmissConstraints()
                self.scrollStatus = .down
                print("Dragging down done")
                self.animationGroup.leave()
            }
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = getColor(hexValue: 0xEDEFF4)
        
    }
    
}




