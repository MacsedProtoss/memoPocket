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
    
    var calendarBtn : UIButton = UIButton()
    var mainTable : UITableView = UITableView()
    
    var addBtn : UIButton = UIButton()
    private var timeTimer : Timer? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = getColor(hexValue: 0xF0F1F5)
        
        
        timeLabel = getTimeLabel()
        dateLabel = getDateLabel()
        calendarBtn = getCalendarBtn()
        bottomView = getBottomView()
        mainTable = getMainTable()
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
    
    
    
    
    func getCalendarBtn() -> UIButton {
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
    
    
    func getAddBtn() -> UIButton {
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
    
    
    func getMainTable() -> UITableView {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.separatorStyle = .none
        table.allowsSelection = false
        self.addSubview(table)
        table.snp.makeConstraints{(make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(274)
            make.bottom.equalToSuperview()
        }
        return table
    }
    
    func getTimeLabel() -> UILabel {
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
    
    func getDateLabel() -> UILabel {
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
    
    func getBottomView () -> UIView {
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
    
    
    
}
