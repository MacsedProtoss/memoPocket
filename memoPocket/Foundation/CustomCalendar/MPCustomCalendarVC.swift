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
    private var prevSelect : Date? = nil
    
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
        }else{
            
            let date = CalendarUtil.shared.getDateByYMD(byYear: cell.year, byMonth: cell.month, byDay: cell.day)
            
            var intervalStart : Date? = nil
            var intervalEnd : Date? = nil
            
            for (start,end) in mutilChooseDate{
                let interval = CalendarUtil.shared.getDatesFromInterval(startDate: start, endDate: end)
                if interval.contains(date){
                    intervalStart = start
                    intervalEnd = end
                    break
                }
            }
            
            if prevSelect == nil{

                if intervalStart == nil{
                    
                    var ahead : Date? = nil
                    var behind : Date? = nil
                    
                    for (start,end) in mutilChooseDate{
                        
                        if CalendarUtil.shared.isAhead(from: start, date: date){
                            ahead = start
                            break
                        }
                            
                        if CalendarUtil.shared.isBehind(from: end, date: date){
                            behind = end
                            break
                        }
                        
                    }
                    
                    if ahead != nil{
                        prevSelect = nil
                        mutilChooseDate.removeValue(forKey: intervalStart!)
                        mutilChooseDate[date] = intervalEnd!
                        drawNewMutil(startAt: date, endAt: intervalEnd!)
                    }else if behind != nil{
                        prevSelect = nil
                        mutilChooseDate[intervalStart!] = date
                        drawNewMutil(startAt: intervalStart!, endAt: date)
                    }else{
                        prevSelect = date
                        cell.handleMutilChooseUI(forStatus: true, isHead: true, isTail: true)
                    }
                    
                }else{
                    
                    mutilChooseDate[intervalStart!] = date.addingTimeInterval(-24*60*60)
                    
                    mutilChooseDate[date.addingTimeInterval(24*60*60)] = intervalEnd!
                    
                    drawNewMutil(startAt: intervalStart!, endAt: mutilChooseDate[intervalStart!]!)
                    drawNewMutil(startAt: date.addingTimeInterval(24*60*60), endAt: intervalEnd!)
                }
                
            }else{
                
                if intervalStart == nil{
                    if prevSelect!.compare(date) == .orderedAscending{
                        mutilChooseDate[prevSelect!] = date
                        drawNewMutil(startAt: prevSelect!, endAt: date)
                    }else{
                        mutilChooseDate[date] = prevSelect!
                        drawNewMutil(startAt: date, endAt: prevSelect!)
                    }
                    prevSelect = nil
                }else{
                    if prevSelect!.compare(intervalStart!) == .orderedAscending{
                        mutilChooseDate[prevSelect!] = intervalEnd!
                        mutilChooseDate.removeValue(forKey: intervalStart!)
                        drawNewMutil(startAt: prevSelect!, endAt: intervalEnd!)
                    }else{
                        mutilChooseDate[intervalStart!] = prevSelect!
                        drawNewMutil(startAt: intervalStart!, endAt: prevSelect!)
                    }
                    prevSelect = nil
                }
                
            }
            
        }
    }
    
    private func drawNewMutil(startAt start: Date,endAt end : Date){
        
    }
    
}
