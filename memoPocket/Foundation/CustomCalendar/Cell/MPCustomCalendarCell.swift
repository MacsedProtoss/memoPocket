//
//  MPCustomCalendarCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/3.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomCalendarCell : UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    var year : Int!
    var month : Int!
    
    var calendar : UICollectionView!
    private var titleLabel : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(year : Int,month : Int){
        self.init()
        self.year = year
        self.month = month
        getView()
    }
    
    private func getView(){
        self.backgroundColor = .white
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.init(name: "PingFangSC-Semibold", size: 22.reSized)
        titleLabel.textColor = getColor(hexValue: 0x49506C, alpha: 0.8)
        titleLabel.textAlignment = .left
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(22.reSized)
            make.height.equalTo(31.reSized)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        if month == 1{
            titleLabel.text = "\(year!)年\(month!)月"
        }else{
            titleLabel.text = "\(month!)月"
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16.reSized
        flowLayout.minimumInteritemSpacing = 0
        calendar = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        calendar.register(MPCustomCalendarDayCell.self, forCellWithReuseIdentifier: "day cell")
        calendar.backgroundColor = .white
        calendar.dataSource = self
        calendar.isDirectionalLockEnabled = true
        calendar.showsVerticalScrollIndicator = false
        calendar.showsHorizontalScrollIndicator = false
        calendar.isScrollEnabled = false
        
        self.addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(54.reSized)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CalendarUtil.shared.getCellCount(ofYear: year, ofMonth: month)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if MPCustomCalendarCacheBuilder.CalendarCache.data.count != 0{
            let index = CalendarUtil.shared.getMonthIndex(ofYear: year, ofMonth: month)
            let data = MPCustomCalendarCacheBuilder.CalendarCache.data[index]
            let firstDay = data.firstDay
            
            if indexPath.row + 2 > firstDay{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day cell", for: indexPath) as! MPCustomCalendarDayCell
                cell.day = data.data[indexPath.row + 1 - firstDay].day
                cell.month = data.month
                cell.year = data.year
                
                cell.getView()
                
                if data.data[indexPath.row + 1 - firstDay].isToday{
                    cell.singleChoose = true
                }
                
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day cell", for: indexPath) as! MPCustomCalendarDayCell
                cell.isUserInteractionEnabled = false
                return cell
            }
            
            
        }else{
            if indexPath.row + 2 > CalendarUtil.shared.getFirstDayOfMonth(ofYear: year, ofMonth: month){
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day cell", for: indexPath) as! MPCustomCalendarDayCell
                
                cell.day = indexPath.row + 1 - CalendarUtil.shared.getFirstDayOfMonth(ofYear: year, ofMonth: month) + 1
                cell.year = year
                cell.month = month
                
                cell.getView()
                
                if CalendarUtil.shared.isToday(ofYear: year, ofMonth: month, ofDay: indexPath.row + 1 - CalendarUtil.shared.getFirstDayOfMonth(ofYear: year, ofMonth: month) + 1){
                    cell.singleChoose = true
                }
                
                return cell
                
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day cell", for: indexPath) as! MPCustomCalendarDayCell
                cell.isUserInteractionEnabled = false
                return cell
            }
        }

    }
    
}
