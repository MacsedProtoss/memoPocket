//
//  MPCustomCalendarCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/3.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomCalendarCell : UITableViewCell{
    
    var year : Int!
    var month : Int!
    
    var calendar : UICollectionView!
    private var titleLabel : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        getView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(year : Int,month : Int){
        self.init()
        self.year = year
        self.month = month
    }
    
    private func getView(){
        self.backgroundColor = .clear
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.init(name: "PingFangSC-Semibold", size: 22.reSized)
        titleLabel.textColor = getColor(hexValue: 0x49506C, alpha: 0.8)
        titleLabel.textAlignment = .left
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(22.reSized)
            make.height.equalTo(31.reSized)
            make.width.equalTo(47.reSized)
            make.trailing.equalToSuperview()
        }
        
        if month == 1{
            titleLabel.text = "\(String(describing: year))年\(String(describing: month))月"
        }else{
            titleLabel.text = "\(String(describing: month))月"
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        calendar = UICollectionView()
        calendar.collectionViewLayout = flowLayout
        
        self.addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(54.reSized)
        }
        
    }
    
}
