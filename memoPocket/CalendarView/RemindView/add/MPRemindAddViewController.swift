//
//  MPRemindAddViewController.swift
//  memoPocket
//
//  Created by Macsed on 2020/3/14.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPRemindAddViewController : MPCustomInputTableController{
    
    var backBtn : UIButton!
    var topLayer : UIView!
    var finishBtn : UIButton!
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        view.backgroundColor = getColor(hexValue: 0xF0F1F5, alpha: 1.0)
        getTop()
        getBottom()
        getTable()
    }
    
    private func getTop(){
        topLayer = {
            let v = UIView()
            v.backgroundColor = .clear
            
            view.addSubview(v)
            v.snp.makeConstraints { (make) in
                make.leading.trailing.top.equalToSuperview()
                if PhoneType.thisPhone.isUsingSafeArea(){
                    make.height.equalTo(90.reSized)
                }else{
                    make.height.equalTo((90-44).reSized)
                }
                
            }
            return v
        }()
        
        let _ : UILabel = {
            let label = UILabel()
            
            label.text = "新建提醒"
            label.textAlignment = .center
            label.font = UIFont.init(name: "PingFangSC-Medium", size: 20.reSized)
            label.textColor = getColor(hexValue: 0x49506C, alpha: 1)
            
            topLayer.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
                make.height.equalTo(28.reSized)
            }
            
            return label
        }()
        
        backBtn = {
            let btn = UIButton(type: .system)
            
            btn.setImage(UIImage.init(systemName: "chevron.left")?.reSetSize(Size: CGSize(width: 14.reSized, height: 20.reSized)).withTintColor(getColor(hexValue: 0x686E83, alpha: 0.8), renderingMode: .alwaysOriginal), for: .normal)
            
            topLayer.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-4.reSized)
                make.leading.equalTo(29.reSized)
                make.width.equalTo(14.reSized)
                make.height.equalTo(20.reSized)
            }
            
            return btn
        }()
        
    }
    
    private func getBottom(){
        finishBtn = {
            let btn = UIButton(type: .system)
            btn.backgroundColor = getColor(hexValue: 0x92A0F8, alpha: 1)
            btn.layer.cornerRadius = 24.reSized
            btn.setTitle("确认", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.reSized)
            
            view.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                if PhoneType.thisPhone.isUsingSafeArea(){
                    make.bottom.equalToSuperview().offset(-48.reSized)
                }else{
                    make.bottom.equalToSuperview().offset((-48+22).reSized)
                }
                
                make.height.equalTo(48.reSized)
                make.width.equalTo(287.reSized)
                make.centerX.equalToSuperview()
            }
            return btn
        }()
    }
    
    private func getTable(){
        table = {
            let t = UITableView()
            t.backgroundColor = .clear
            t.register(MPCustomInputBaseCell.self, forCellReuseIdentifier: "Custom Input")
            t.dataSource = self
            t.delegate = self
            view.addSubview(t)
            
            t.showsVerticalScrollIndicator = false
            t.showsHorizontalScrollIndicator = false
            
            t.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(topLayer.snp.bottom)
                make.bottom.equalTo(finishBtn.snp.top).offset(-5.reSized)
            }
            
            let footer = UIView()
            footer.backgroundColor = .clear
            t.tableFooterView = footer
            t.separatorStyle = .none
            
            t.allowsSelection = false
            return t
        }()
    }
    
}
