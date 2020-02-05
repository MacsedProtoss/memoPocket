//
//  MPCustomCalendarVC.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/2.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomCalendarVC : UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    private var type : CalendarType = .single
    private var mainView : MPCustomCalendarView!
    var delegate : MPCustomCalendarDelegate?
    private var singleChooseDate : Date = Date()
    private var mutilChooseDate : Dictionary<Date,Date> = [:]
    
    convenience init(type : CalendarType){
        self.init()
        self.type = type
    }
    
    override func viewDidLoad() {
        getView()
        mainView.backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        mainView.confirmBtn.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainView.calendar.scrollToRow(at: IndexPath.init(row: 12, section: 0), at: .top, animated: false)
    }
    
    func getView(){
        view.backgroundColor = .clear
        mainView = MPCustomCalendarView()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
    }
    
    @objc func backBtnPressed(){
        delegate?.calendarViewDismiss()
    }
    
    @objc func confirmPressed(){
        if type == .single{
            delegate?.changeDateTo(date: singleChooseDate)
        }else if type == .comble{
            var output : [Date] = []
            for (start,end) in mutilChooseDate{
                for date in CalendarUtil.shared.getDatesFromInterval(startDate: start, endDate: end){
                    output.append(date)
                }
            }
            delegate?.changeDatesTo(dates: output)
        }
        
        delegate?.calendarViewDismiss()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 36
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let month = (CalendarUtil.shared.getStartMonth() + indexPath.row)%12==0 ? 12 : (CalendarUtil.shared.getStartMonth() + indexPath.row)%12
        
        let cell = MPCustomCalendarCell(year: CalendarUtil.shared.getStartYear() + indexPath.row/12, month: month)
        cell.calendar.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let month = (CalendarUtil.shared.getStartMonth() + indexPath.row)%12==0 ? 12 : (CalendarUtil.shared.getStartMonth() + indexPath.row)%12
        let year = CalendarUtil.shared.getStartYear() + indexPath.row/12
        
        return getMonthHeight(year: year, month: month)
        
    }
    
    private func getMonthHeight(year : Int,month :Int) -> CGFloat {
        let count = CalendarUtil.shared.getCellCount(ofYear: year, ofMonth: month)
        
        return 49.reSized + CGFloat(count/7 + 1)*40.reSized + CGFloat(count/7)*16.reSized + 31.reSized
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(380.0/7).reSized, height: 40.reSized)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MPCustomCalendarDayCell
        if type == .single{
            let originCell = mainView.calendar.cellForRow(at: IndexPath(row: CalendarUtil.shared.getMonthCellIndex(date: singleChooseDate), section: 0)) as! MPCustomCalendarCell
            let dayCell = originCell.calendar.cellForItem(at: IndexPath(row: CalendarUtil.shared.getDayCellIndex(date: singleChooseDate), section: 0)) as! MPCustomCalendarDayCell
            dayCell.singleChoose = false
            
            cell.singleChoose = true
            
            singleChooseDate = CalendarUtil.shared.getDateByYMD(byYear: cell.year, byMonth: cell.month, byDay: cell.day)
            
            mainView.titleDate = singleChooseDate
        }
    }
    
}
