//
//  MPCustomCalendarView.swift
//  memoPocket
//
//  Created by Macsed on 2020/1/31.
//  Copyright © 2020 Macsed. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MPCustomCalendarView: UIView {
    
    private var headLayer : UIView!
    private var bottomLayer : UIView!
    private var mainView : UIView!
    var backBtn : UIButton!
    private var topLabel : UILabel!
    var titleDate : Date?{
        didSet{
            topLabel.text = titleDate?.toString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundImage : UIImage?){
        self.init()
        getBasicView(backgroundImage: backgroundImage)
    }
    
    func getBasicView(backgroundImage : UIImage?){
        getBackGround(backgroundImage : backgroundImage)
        getMainView()
        getHead()
    }
    
    func getBackGround(backgroundImage : UIImage?){
        
        let imageView = UIImageView(image: backgroundImage)
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        let mask = UIView()
        mask.backgroundColor = getColor(hexValue: 0x404F6A, alpha: 0.28)
        self.addSubview(mask)
        mask.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func getMainView(){
        mainView = UIView()
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 20.reSized
        self.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(198.reSized)
            make.width.equalTo(380.reSized)
            make.height.equalTo(563.reSized)
        }
        
    }
    
    func getHead(){
        headLayer = UIView()
        headLayer.backgroundColor = UIColor.white
        headLayer.layer.shadowColor = getColor(hexValue: 0xE5EAF6, alpha: 0.54).cgColor
        headLayer.layer.shadowOffset = CGSize(width: 0, height: 13.25)
        headLayer.layer.shadowOpacity = 1
        headLayer.layer.shadowRadius = 13.25
        
        mainView.addSubview(headLayer)
        headLayer.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(563/91)
        }
        
        backBtn = UIButton(type: .system)
        backBtn.setImage(UIImage.init(named: "backBtn")?.reSetSize(Size: CGSize(width: 9.reSized, height: 14.reSized)), for: .normal)
        
        headLayer.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(29.reSized)
            make.top.equalToSuperview().offset(21.reSized)
            make.width.equalTo(9)
            make.height.equalTo(14)
        }
        
        topLabel = UILabel()
        topLabel.font = UIFont(name: "Avenir Heavy", size: 22.reSized)
        topLabel.textColor = getColor(hexValue: 0x696F83, alpha: 1.0)
        topLabel.textAlignment = .center
        topLabel.text = Date().toString
        headLayer.addSubview(topLabel)
        
        topLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12.reSized)
            make.height.equalTo(31.reSized)
        }
        
        for i in 0...6{
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = getColor(hexValue: 0x75798B, alpha: 0.8)
            label.font = UIFont(name: "PingFangSC-Regular", size: 14.reSized)
            label.text = CalendarWeekDays[i]
            
            headLayer.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset((i*380/7).reSized)
                make.top.equalToSuperview().offset(62.reSized)
                make.height.equalTo(20.reSized)
                make.width.equalTo((380/7).reSized)
            }
            
        }
        
    }
    
    
    
}
