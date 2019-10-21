//
//  RemindView.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/17.
//  Copyright © 2019 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class RemindView : UIView {
    private var timeLabel : UILabel = UILabel()
    private var dateLabel : UILabel = UILabel()
    private var bottomView : UIView = UIView()
    private var contentView : UIView = UIView()
    
    var calendarBtn : UIButton = UIButton()
    
    var tables : [UITableView] = []
    
    var mainScroll : UIScrollView = UIScrollView()
    
    var addBtn : UIButton = UIButton()
    private var timeTimer : Timer? = nil
    var switcher : CustomSwitcherView = CustomSwitcherView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = getColor(hexValue: 0xF0F1F5)
        
        timeLabel = getTimeLabel()
        dateLabel = getDateLabel()
        calendarBtn = getCalendarBtn()
        switcher = getSwither()
        bottomView = getBottomView()
        
        mainScroll = getScroll()
        
        for index in 0..<2 {
            let table = getContentTable(at: index)
            tables.append(table)
        }
        
        addBtn = getAddBtn()
        
        
        
        timeTimer = Timer(timeInterval: 1, repeats: true, block: {_ in
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            self.timeLabel.text = formatter.string(from: date)
            print("timer alive")
       })
        
        RunLoop.current.add(timeTimer!, forMode: .common)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getScroll() -> UIScrollView {
        let scroll = UIScrollView()
        scroll.isDirectionalLockEnabled = true
        scroll.backgroundColor = UIColor.clear
        scroll.isPagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.contentSize = CGSize(width: screensize.width * CGFloat(2), height: screensize.height - CGFloat(274))
        self.addSubview(scroll)
        scroll.snp.makeConstraints{(make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(274)
        }
        
        scroll.addSubview(contentView)
        contentView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        
        return scroll
    }
    
    private func getSwither() -> CustomSwitcherView {
        let view = CustomSwitcherView(num: 2, title: ["待完成","已完成"], offset: 50, maxLenPerSection: 57)
        self.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(224)
            make.height.equalTo(30)
        }
        return view
    }
    
    
    private func getCalendarBtn() -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage.init(named: "changeDateBtn")?.reSetSize(Size: CGSize(width: 80, height: 23)).withRenderingMode(.alwaysOriginal), for: .normal)
        self.addSubview(btn)
        btn.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(161)
            make.height.equalTo(17)
            make.width.equalTo(80)
            make.top.equalTo(dateLabel.snp.top).offset(2)
        }
        return btn
    }
    
    
    private func getAddBtn() -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage.init(named: "addBtn")?.reSetSize(Size: CGSize(width: 60, height: 60)).withRenderingMode(.alwaysOriginal), for: .normal)
        self.addSubview(btn)
        btn.snp.makeConstraints{(make) in
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(60)
            make.bottom.equalToSuperview().offset(-170)
        }
        btn.layer.shadowColor = UIColor(red: 0.78, green: 0.81, blue: 0.88, alpha: 1).cgColor
        btn.layer.shadowOffset = CGSize(width: 1.5, height: 2.0)
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 3
        return btn
    }
    
    
    
    private func getContentTable(at index : Int) -> UITableView {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.separatorStyle = .none
        table.allowsSelection = false
        mainScroll.addSubview(table)
        table.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(screensize.width * CGFloat(index))
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(screensize.width)
        }
        table.tag = index
        return table
    }
    
    private func getTimeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "PingFangSC-Semibold", size: 52)
        label.textColor = getColor(hexValue: 0x49506C)
        self.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(84)
            make.height.equalTo(71)
            make.width.equalTo(140)
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        label.text = formatter.string(from: date)
        return label
    }
    
    private func getDateLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "PingFangSC-Medium", size: 16)
        label.textColor = getColor(hexValue: 0x686E83)
        self.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(34)
            make.top.equalTo(timeLabel.snp.bottom).offset(2)
            make.height.equalTo(23)
            make.width.equalTo(130)
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年MM月dd日"
        label.text = formatter.string(from: date)
        return label
    }
    
    private func getBottomView () -> UIView {
        let view = UIView()
        let topColor = UIColor(red: 0.66, green: 0.68, blue: 0.87, alpha: 0.0)
        let midColor = UIColor(red: 0.56, green: 0.62, blue: 0.92, alpha: 0.04)
        let bottomColor = UIColor(red: 0.35, green: 0.38, blue: 0.82, alpha: 0.21)
        let gradientColors = [topColor.cgColor,midColor.cgColor, bottomColor.cgColor]
        let gradientLocations:[NSNumber] = [0.0, 0.3,1.0]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        gradientLayer.frame = CGRect(x: 0, y: 0, width: screensize.width, height: 128)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        self.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(128)
        }
        return view
        
    }
    
    func swithContent(from: Int ,to:Int){
        
        print("content switch start from \(from) to \(to)")
        
        mainScroll.isUserInteractionEnabled = false
        UIView.transition(with: mainScroll, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.mainScroll.contentOffset = CGPoint(x: screensize.width*CGFloat(to), y: 0)
        },completion:nil)
        
        mainScroll.isUserInteractionEnabled = true
        
        mainScroll.contentOffset = CGPoint(x: screensize.width*CGFloat(to), y: 0)
        
        print("content switch finished")
    }
    
    func addBtnUP(){
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation.autoreverses = false
        animation.fromValue = self.layer.position
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.toValue = CGPoint(x: self.layer.position.x, y: self.layer.position.y + 113)
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        addBtn.isUserInteractionEnabled = false
        addBtn.layer.add(animation, forKey: "basic")
    }
    
    func addBtnDown(){
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation.autoreverses = false
        animation.fromValue = self.layer.position
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.toValue = CGPoint(x: self.layer.position.x, y: self.layer.position.y - 113)
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        addBtn.isUserInteractionEnabled = false
        addBtn.layer.add(animation, forKey: "basic")
    }
    
    
    
}
