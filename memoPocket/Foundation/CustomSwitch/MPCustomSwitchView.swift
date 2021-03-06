//
//  CustomSwitchView.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/18.
//  Copyright © 2019 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class CustomSwitcherView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         
    }
    
    var sections : [UIButton] = []
    var selectedIndex : Int = 0
    
    private var statusBar : UIView = UIView()
    private var mainScroll : UIScrollView = UIScrollView()
    
    private var btnList : [String] = []
    
    private var offsetPerSection : CGFloat = 0
    private var lenPerSection : CGFloat = 0
    private var btnNum : Int = 0
    
    
    convenience init(num : Int,title : [String],offset:CGFloat,maxLenPerSection : CGFloat){
        let width : CGFloat = offset * CGFloat(num - 1) + maxLenPerSection*CGFloat((num-1))
        let rect = CGRect(x: 0, y: 0, width: width > screensize.width ? screensize.width : width, height: 30.reSized)
        self.init(frame : rect)
        self.backgroundColor = UIColor.clear
        self.offsetPerSection = offset
        self.lenPerSection = maxLenPerSection
        self.btnNum = num
        self.btnList = title
        
        self.mainScroll = getmainScroll()
        for index in 0..<num{
            let btn = getSection(name: btnList[index], at: index)
            sections.append(btn)
        }
        
        self.statusBar = getSatusBar()
        print("\(sections.count)")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getSection(name : String ,at index:Int) -> UIButton {
        let btn = UIButton(type:.system)
        
        btn.tag = index
        
        btn.titleLabel?.textAlignment = .center
        
        if (index == selectedIndex){
            btn.setTitleColor(getColor(hexValue:0x49506C, alpha: 1.0), for: .normal)
            btn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 18.reSized)
        }else{
            btn.setTitleColor(getColor(hexValue:0x6B7186, alpha: 1.0), for: .normal)
            btn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 16.reSized)
        }
        
        btn.setTitle(name, for: .normal)
        
        mainScroll.addSubview(btn)
        btn.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(index == selectedIndex ? 0 : 2)
            make.leading.equalToSuperview().offset(Int(offsetPerSection)*index + Int(lenPerSection)*index)
            make.width.equalTo(lenPerSection)
            make.height.equalTo(index == selectedIndex ? 25.reSized:22.reSized)
            
        }
        
        return btn
    }
    
    private func getmainScroll() -> UIScrollView {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor.clear
        let width : CGFloat = offsetPerSection * CGFloat(btnNum - 1) + lenPerSection*CGFloat(btnNum)
        let size = CGSize(width: width, height: 30.reSized)
        scroll.contentSize = size
        scroll.isDirectionalLockEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        
        self.addSubview(scroll)
        scroll.snp.makeConstraints{(make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(37.reSized)
            make.trailing.equalToSuperview().offset(-37.reSized)
        }
        
        return scroll
    }
    
    private func getSatusBar() -> UIView {
        let view = UIView()
        view.backgroundColor = getColor(hexValue: 0x8FA1FF, alpha: 1.0)
        view.layer.cornerRadius = 2.reSized
        mainScroll.addSubview(view)
        
        view.snp.makeConstraints{(make) in
            make.centerX.equalTo(sections[selectedIndex].snp.centerX)
            make.top.equalToSuperview().offset(26.reSized)
            make.height.equalTo(4.reSized)
            make.width.equalTo(lenPerSection)
        }
        
        return view
    }
    
    func moveStatus(from : Int , to : Int){
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation.autoreverses = false
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        let originX = statusBar.layer.position.x
        let fromX = originX + offsetPerSection*CGFloat(from) + lenPerSection*CGFloat(from)
        let toX = originX + offsetPerSection*CGFloat(to) + lenPerSection*CGFloat(to)
        
        animation.fromValue = CGPoint(x: fromX, y: statusBar.layer.position.y)
        animation.toValue = CGPoint(x: toX, y: statusBar.layer.position.y)
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        self.isUserInteractionEnabled = false
        statusBar.layer.add(animation, forKey: "basic")
        
        btnDeSelected(at: from)
        btnSelected(at: to)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.isUserInteractionEnabled = true
            print("status Transition Finished")
        }
        
    }
    
    private func btnSelected(at index:Int){
        
        print("btn Selected Called")
        
//        let scaleAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.contentsScale))
//        scaleAnimation.autoreverses = false
//        scaleAnimation.fillMode = .forwards
//        scaleAnimation.isRemovedOnCompletion = false
//        scaleAnimation.fromValue = 1
//        scaleAnimation.toValue = 1.125
//        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
//        scaleAnimation.duration = 0.1
//
//        sections[index].layer.add(scaleAnimation, forKey: "basic")
        
//        UIView.transition(with: sections[index].titleLabel!, duration: 0.2, options: [.curveEaseOut ,.transitionCrossDissolve], animations: {
//            self.sections[index].titleLabel!.textColor = getColor(hexValue:0x49506C)
//            self.sections[index].titleLabel!.font = UIFont(name: "PingFangSC-Semibold", size: 18)
//        },
//        completion: {finished in
//            if finished{
//
//
//            }
//        })
//
        self.sections[index].titleLabel!.font = UIFont(name: "PingFangSC-Semibold", size: 18.reSized)
        self.sections[index].setTitleColor(getColor(hexValue:0x49506C, alpha: 1.0), for: .normal)
        
        
    }
    
    private func btnDeSelected(at index:Int){
//        let scaleAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.contentsScale))
//        scaleAnimation.autoreverses = false
//        scaleAnimation.fillMode = .forwards
//        scaleAnimation.isRemovedOnCompletion = false
//        scaleAnimation.fromValue = 1
//        scaleAnimation.toValue = 16/18
//        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
//        scaleAnimation.duration = 0.1
//
//        sections[index].layer.add(scaleAnimation, forKey: "basic")
        
//        UIView.transition(with: sections[index].titleLabel!, duration: 0.2, options: [.curveEaseOut ,.transitionCrossDissolve], animations: {
//            self.sections[index].titleLabel!.textColor = getColor(hexValue:0x6B7186)
//            self.sections[index].titleLabel!.font = UIFont(name: "PingFangSC-Medium", size: 16)
//        },
//        completion: {finished in
//            if finished {
//
//
//            }
//        })
        
        self.sections[index].titleLabel!.font = UIFont(name: "PingFangSC-Medium", size: 16.reSized)
        self.sections[index].setTitleColor(getColor(hexValue:0x6B7186, alpha: 1.0), for: .normal)
        
        
    }
    
    
    
}

