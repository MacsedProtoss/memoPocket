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
        view.layer.shadowColor = getColor(hexValue: 0xC9D5F1, alpha: 1.0).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4.01)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 18.reSized
        self.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(380.reSized)
            make.height.equalTo(88.reSized)
        }
        return view
    }
    
    private func getStick() -> UIView {
        let view = UIView()
        
        view.setHalfCorneredRect(withBounds: CGRect(x: 0, y: 0, width: 6, height: 45), radius: 6)
        view.backgroundColor = getColor(hexValue: 0x8FA1FF, alpha: 1.0)
        
        content!.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(6.reSized)
            make.height.equalTo(45.reSized)
        }
        
        return view
    }
    
    private func getTitle(title : String) -> UILabel {
        let label = UILabel()
        label.textColor = getColor(hexValue: 0x49506C, alpha: 1.0)
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 18.reSized)
        label.text = title
        
        content!.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(21.reSized)
            make.top.equalToSuperview().offset(15.reSized)
            make.height.equalTo(25.reSized)
            make.trailing.equalToSuperview().offset(50.reSized)
        }
        
        return label
    }
    
    private func getFromLayer(color : layerColor) -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 11
        
        switch color {
        case .red:
            let topColor = getColor(hexValue: 0xF4BBBE, alpha: 1.0)
            let bottomColor = getColor(hexValue: 0xF5C0A5, alpha: 1.0)
            let gradientColors = [topColor.cgColor, bottomColor.cgColor]
            let gradientLocations:[NSNumber] = [0.0,1.0]
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = gradientColors
            gradientLayer.locations = gradientLocations
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 76.reSized, height: 22.reSized)
            view.layer.insertSublayer(gradientLayer, at: 0)
        case .blue:
            let topColor = UIColor(red: 140/255, green: 176/255, blue: 1, alpha: 1)
            let bottomColor = UIColor(red: 128/255, green: 163/255, blue: 1, alpha: 1)
            let gradientColors = [topColor.cgColor, bottomColor.cgColor]
            let gradientLocations:[NSNumber] = [0.0,1.0]
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = gradientColors
            gradientLayer.locations = gradientLocations
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 76.reSized, height: 22.reSized)
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        view.layer.masksToBounds = true
        
        content!.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(21.reSized)
            make.top.equalTo(titleLabel!.snp.bottom).offset(4.reSized)
            make.height.equalTo(22.reSized)
            make.width.equalTo(76.reSized)
        }
        
        
        return view
    }
    
    private func getFromLabel(from : String) -> UILabel {
        let label = UILabel()
        label.textColor = getColor(hexValue: 0xFFFFFF, alpha: 1.0)
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12.reSized)
        label.text = "来自：" + from
        
        fromLayer!.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.center.equalToSuperview()
            make.height.equalTo(17.reSized)
            make.width.equalTo(64.reSized)
        }
        
        return label
    }
    
    private func getTimeLabel(time : String) -> UILabel {
        let label = UILabel()
        label.textColor = getColor(hexValue: 0x686E83, alpha: 1.0)
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12.reSized)
        label.text = time
        
        content!.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.centerY.equalTo(fromLabel!.snp.centerY)
            make.height.equalTo(17.reSized)
            make.leading.equalTo(fromLayer!.snp.trailing).offset(8.reSized)
            make.width.equalTo(190.reSized)
        }
        
        return label
    }
    
    
}

