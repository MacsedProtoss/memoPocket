//
//  RemindCell.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import SnapKit
import UIKit

class RemindCell:UITableViewCell{
    
    var content : UIView? = nil
    private var blueStick : UIView? = nil
    private var titleLabel : UILabel? = nil
    private var fromLayer : UIView? = nil
    private var fromLabel : UILabel? = nil
    private var timeLabel : UILabel? = nil
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    convenience init(title : String,time :String , from : String, color : layerColor){
        self.init()
        initBasicUI()
        blueStick = getStick()
        titleLabel = getTitle(title: title)
        fromLayer = getFromLayer(color: color)
        fromLabel = getFromLabel(from: from)
        timeLabel = getTimeLabel(time: time)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initBasicUI(){
        self.backgroundColor = UIColor.clear
        content = getContentView()
    }
    
    private func getContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = getColor(hexValue: 0xC9D5F1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4.01)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 18
        self.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(345)
            make.height.equalTo(80)
        }
        return view
    }
    
    private func getStick() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = getColor(hexValue: 0x8FA1FF)
        
        content!.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(6)
            make.height.equalTo(45)
        }
        return view
    }
    
    private func getTitle(title : String) -> UILabel {
        let label = UILabel()
        label.textColor = getColor(hexValue: 0x49506C)
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 18)
        label.text = title
        
        content!.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(21)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(25)
            make.trailing.equalToSuperview().offset(50)
        }
        
        return label
    }
    
    private func getFromLayer(color : layerColor) -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 11
        
        switch color {
        case .red:
            let topColor = getColor(hexValue: 0xF4BBBE)
            let bottomColor = getColor(hexValue: 0xF5C0A5)
            let gradientColors = [topColor.cgColor, bottomColor.cgColor]
            let gradientLocations:[NSNumber] = [0.0,1.0]
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = gradientColors
            gradientLayer.locations = gradientLocations
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 76, height: 22)
            view.layer.insertSublayer(gradientLayer, at: 0)
        case .blue:
            let topColor = UIColor(red: 140/255, green: 176/255, blue: 1, alpha: 1)
            let bottomColor = UIColor(red: 128/255, green: 163/255, blue: 1, alpha: 1)
            let gradientColors = [topColor.cgColor, bottomColor.cgColor]
            let gradientLocations:[NSNumber] = [0.0,1.0]
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = gradientColors
            gradientLayer.locations = gradientLocations
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 76, height: 22)
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        view.layer.masksToBounds = true
        
        content!.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(21)
            make.top.equalTo(titleLabel!.snp.bottom).offset(4)
            make.height.equalTo(22)
            make.width.equalTo(76)
        }
        
        
        return view
    }
    
    private func getFromLabel(from : String) -> UILabel {
        let label = UILabel()
        label.textColor = getColor(hexValue: 0xFFFFFF)
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12)
        label.text = "来自：" + from
        
        fromLayer!.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.center.equalToSuperview()
            make.height.equalTo(17)
            make.width.equalTo(64)
        }
        
        return label
    }
    
    private func getTimeLabel(time : String) -> UILabel {
        let label = UILabel()
        label.textColor = getColor(hexValue: 0x686E83)
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12)
        label.text = time
        
        content!.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.centerY.equalTo(fromLabel!.snp.centerY)
            make.height.equalTo(17)
            make.leading.equalTo(fromLayer!.snp.trailing).offset(8)
            make.width.equalTo(190)
        }
        
        return label
    }
    
    
}

