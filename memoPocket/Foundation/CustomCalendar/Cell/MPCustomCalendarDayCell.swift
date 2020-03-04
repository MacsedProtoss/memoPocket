//
//  MPCustomCalendarDayCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/3.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomCalendarDayCell : UICollectionViewCell{
    
    var day : Int = 0
    var month : Int = 0
    var year : Int = 0
    private var label : UILabel!
    private var chooseLayer : UIView!
    
    var singleChoose : Bool = false{
        didSet{
            chooseLayer.isHidden = !singleChoose
        }
    }
    
    func handleMutilChooseUI(forStatus status : Bool,isHead : Bool,isTail : Bool ){
        if status == false{
            self.backgroundColor = .clear
            self.setCorner(byRoundingCorners: [], withBounds: CGRect(x: 0, y: 0, width: MPCustomCalendarDayCellCache.base, height: MPCustomCalendarDayCellCache.reSized40), radius: MPCustomCalendarDayCellCache.reSized20)
        }else{
            self.backgroundColor = getColor(hexValue: 0x92A0F8, alpha: 1.0)
            if isHead && !isTail{
                self.setCorner(byRoundingCorners: [.topLeft,.bottomLeft], withBounds: CGRect(x: 0, y: 0, width: MPCustomCalendarDayCellCache.base, height: MPCustomCalendarDayCellCache.reSized40), radius: MPCustomCalendarDayCellCache.reSized20)
            }else if isTail && !isHead {
                self.setCorner(byRoundingCorners: [.topRight,.bottomRight], withBounds: CGRect(x: 0, y: 0, width: MPCustomCalendarDayCellCache.base, height: MPCustomCalendarDayCellCache.reSized40), radius: MPCustomCalendarDayCellCache.reSized20)
            }else if !isHead && !isTail{
                self.setCorner(byRoundingCorners: [], withBounds: CGRect(x: 0, y: 0, width: MPCustomCalendarDayCellCache.base, height: MPCustomCalendarDayCellCache.reSized40), radius: MPCustomCalendarDayCellCache.reSized20)
            }else{
                self.setCorner(byRoundingCorners: [.topLeft,.topRight,.bottomLeft,.bottomRight], withBounds: CGRect(x: 0, y: 0, width: MPCustomCalendarDayCellCache.base, height: MPCustomCalendarDayCellCache.reSized40), radius: MPCustomCalendarDayCellCache.reSized20)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(day : Int){
        self.init()
        self.day = day
        getView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getView(){
        
        if day > 0{
            
            chooseLayer = UIView()
            chooseLayer.backgroundColor = .clear
            chooseLayer.layer.cornerRadius = MPCustomCalendarDayCellCache.reSized20
            chooseLayer.layer.borderColor = getColor(hexValue: 0x6E748A, alpha: 0.35).cgColor
            chooseLayer.layer.borderWidth = 2.reSized
            self.addSubview(chooseLayer)
            chooseLayer.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.height.width.equalTo(MPCustomCalendarDayCellCache.reSized40)
            }
            chooseLayer.isHidden = true
            
            label = UILabel()
            label.text = String(describing: day)
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.font = UIFont(name: "PingFangSC-Medium", size: 22.reSized)
            label.textColor = getColor(hexValue: 0x49506C, alpha: 0.8)
            self.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalToSuperview()
            }
            
        }
        
    }
}
