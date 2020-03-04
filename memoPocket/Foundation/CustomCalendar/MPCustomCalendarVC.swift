//
//  MPCustomCalendarVC.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/2.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomCalendarVC : UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    private var type : CalendarType = .single
    private var mainView : MPCustomCalendarView!
    var delegate : MPCustomCalendarDelegate?
    private var singleChooseDate : Date = Date()
    private var mutilChooseDate : Dictionary<Date,Date> = [:]{
        didSet{
            print("===============")
            for (key,value) in mutilChooseDate{
                print("start \(key)  end \(value)")
            }
        }
    }
    private var prevSelect : Date? = nil
    private var prevRows : [Int] = []
    
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
        
//        if MPCustomCalendarCacheBuilder.CalendarCache.data.count != 0{
//            var height : CGFloat = 0
//            for i in 0..<12{
//                height += MPCustomCalendarCacheBuilder.CalendarCache.data[i].height
//            }
//            mainView.calendar.contentOffset = CGPoint(x: 0, y: height)
//        }else{
        mainView.calendar.scrollToRow(at: IndexPath.init(row: 12, section: 0), at: .top, animated: false)
//        }
        
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
        
        if MPCustomCalendarCacheBuilder.CalendarCache.data.count != 0{
            let data = MPCustomCalendarCacheBuilder.CalendarCache.data[indexPath.row]
            let cell = MPCustomCalendarCell(year: data.year, month: data.month)
            cell.calendar.delegate = self
            return cell
        }else{
            let month = (CalendarUtil.shared.getStartMonth() + indexPath.row)%12==0 ? 12 : (CalendarUtil.shared.getStartMonth() + indexPath.row)%12
            
            let cell = MPCustomCalendarCell(year: CalendarUtil.shared.getStartYear() + (indexPath.row+1)/12, month: month)
            cell.calendar.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if MPCustomCalendarCacheBuilder.CalendarCache.data.count != 0{
            let data = MPCustomCalendarCacheBuilder.CalendarCache.data[indexPath.row]
            return data.height
        }else{
            let month = (CalendarUtil.shared.getStartMonth() + indexPath.row)%12==0 ? 12 : (CalendarUtil.shared.getStartMonth() + indexPath.row)%12
            let year = CalendarUtil.shared.getStartYear() + (indexPath.row+1)/12
            
            return getMonthHeight(year: year, month: month)
        }
        
        
    }
    
    private func getMonthHeight(year : Int,month :Int) -> CGFloat {
        let count = CalendarUtil.shared.getCellCount(ofYear: year, ofMonth: month)
        
        return 49.reSized + CGFloat(count/7 + 1)*40.reSized + CGFloat(count/7)*16.reSized + 31.reSized
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:MPCustomCalendarDayCellCache.base, height: MPCustomCalendarDayCellCache.reSized40)
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
                            if intervalStart == nil{
                                intervalStart = start
                                intervalEnd = end
                            }
                        }
                            
                        if CalendarUtil.shared.isBehind(from: end, date: date){
                            behind = end
                            intervalStart = start
                            intervalEnd = end
                        }
                        
                    }
                    
                    if ahead != nil && behind == nil{
                        prevSelect = nil
                        mutilChooseDate.removeValue(forKey: intervalStart!)
                        mutilChooseDate[date] = intervalEnd!
                    }else if behind != nil && ahead == nil{
                        prevSelect = nil
                        mutilChooseDate[intervalStart!] = date
                    }else if behind == nil && ahead == nil{
                        prevSelect = date
                        cell.handleMutilChooseUI(forStatus: true, isHead: true, isTail: true)
                        mutilChooseDate[date] = date
                    }else{
                        mutilChooseDate[intervalStart!] = mutilChooseDate[ahead!]
                        mutilChooseDate.removeValue(forKey: ahead!)
                    }
                    
                }else{
                    
                    if date == intervalStart! && intervalStart! != intervalEnd!{
                        mutilChooseDate.removeValue(forKey: intervalStart!)
                        mutilChooseDate[intervalStart!.addingTimeInterval(24*60*60)] = intervalEnd!
                        cell.handleMutilChooseUI(forStatus: false, isHead: false, isTail: false)
                    }else if date == intervalEnd! && intervalStart! != intervalEnd!{
                        mutilChooseDate[intervalStart!] = intervalEnd!.addingTimeInterval(-24*60*60)
                        cell.handleMutilChooseUI(forStatus: false, isHead: false, isTail: false)
                    }else if date != intervalStart && date != intervalEnd{
                        mutilChooseDate[intervalStart!] = date.addingTimeInterval(-24*60*60)
                        
                        mutilChooseDate[date.addingTimeInterval(24*60*60)] = intervalEnd!
                        
                        cell.handleMutilChooseUI(forStatus: false, isHead: false, isTail: false)
                        
                    }else if date == intervalStart! && date == intervalEnd!{
                        cell.handleMutilChooseUI(forStatus: false, isHead: false, isTail: false)
                        mutilChooseDate.removeValue(forKey: date)
                    }
                    
                    prevSelect = nil
                    
                }
                
            }else{
                
                if intervalStart == nil{
                    
                    var ahead : Date? = nil
                    var behind : Date? = nil
                    
                    for (start,end) in mutilChooseDate{
                        
                        if CalendarUtil.shared.isAhead(from: start, date: date){
                            ahead = start
                            if intervalStart == nil{
                                intervalStart = start
                                intervalEnd = end
                            }
                        }
                            
                        if CalendarUtil.shared.isBehind(from: end, date: date){
                            behind = end
                            intervalStart = start
                            intervalEnd = end
                        }
                        
                    }
                    
                    if ahead != nil && behind == nil{
                        if prevSelect!.compare(date) == .orderedAscending{
                            mutilChooseDate[prevSelect!] = mutilChooseDate[ahead!]!
                            mutilChooseDate.removeValue(forKey: ahead!)
                        }else{
                            mutilChooseDate.removeValue(forKey: ahead!)
                            mutilChooseDate.removeValue(forKey: prevSelect!)
                            mutilChooseDate[date] = prevSelect!
                        }
                    }else if behind != nil && ahead == nil{
                        if prevSelect!.compare(date) == .orderedAscending{
                            mutilChooseDate.removeValue(forKey: intervalStart!)
                            mutilChooseDate[prevSelect!] = date
                        }else{
                            mutilChooseDate[intervalStart!] = prevSelect!
                            mutilChooseDate.removeValue(forKey: prevSelect!)
                        }
                    }else if ahead == nil && behind == nil{
                        if prevSelect!.compare(date) == .orderedAscending{
                            mutilChooseDate[prevSelect!] = date
                        }else{
                            mutilChooseDate[date] = prevSelect!
                            mutilChooseDate.removeValue(forKey: prevSelect!)
                        }
                    }else{
                        if prevSelect!.compare(date) == .orderedAscending{
                            mutilChooseDate[prevSelect!] = mutilChooseDate[ahead!]!
                            mutilChooseDate.removeValue(forKey: ahead!)
                            mutilChooseDate.removeValue(forKey: intervalStart!)
                        }else{
                            mutilChooseDate[intervalStart!] = prevSelect!
                            mutilChooseDate.removeValue(forKey: ahead!)
                            mutilChooseDate.removeValue(forKey: prevSelect!)
                        }
                    }

                    prevSelect = nil
                }else{
                    
                    if date == prevSelect!{
                        cell.handleMutilChooseUI(forStatus: false, isHead: false, isTail: false)
                        mutilChooseDate.removeValue(forKey: date)
                    }else{
                        if prevSelect!.compare(intervalStart!) == .orderedAscending{
                            mutilChooseDate[prevSelect!] = intervalEnd!
                            mutilChooseDate.removeValue(forKey: intervalStart!)
                        }else{
                            mutilChooseDate[intervalStart!] = prevSelect!
                            mutilChooseDate.removeValue(forKey: prevSelect!)
                        }
                    }
                    
                    prevSelect = nil
                }
                
            }
            
            reDraw(force: true)
        }
    }
    
    private func drawNewMutil(startAt start: Date,endAt end : Date){
        
        print("==draw== start \(start)  end \(end)")
        
        let dates = CalendarUtil.shared.getDatesFromInterval(startDate: start, endDate: end)
        
        for index in 0..<dates.count{
            let date = dates[index]
            let monthCell = mainView.calendar.cellForRow(at: IndexPath(row: CalendarUtil.shared.getMonthCellIndex(date: date), section: 0)) as! MPCustomCalendarCell
            let dayCell = monthCell.calendar.cellForItem(at: IndexPath(row: CalendarUtil.shared.getDayCellIndex(date: date), section: 0)) as! MPCustomCalendarDayCell
            
            if index == 0 && index != dates.count-1 {
                dayCell.handleMutilChooseUI(forStatus: true, isHead: true, isTail: false)
            }else if index == dates.count-1 && index != 0{
                dayCell.handleMutilChooseUI(forStatus: true, isHead: false, isTail: true)
            }else if index == 0 && index == dates.count-1{
                dayCell.handleMutilChooseUI(forStatus: true, isHead: true, isTail: true)
            }else{
                dayCell.handleMutilChooseUI(forStatus: true, isHead: false, isTail: false)
            }
            
        }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainView.calendar && type == .comble{
            reDraw(force: false)
        }
    }
    
    private func reDraw(force : Bool){
        var rows : [Int] = []
        
        if let indexpathes = mainView.calendar.indexPathsForVisibleRows{
            for indexpath in indexpathes{
                rows.append(indexpath.row)
            }
        }
        
        if rows == prevRows && !force{
            return
        }
        
        prevRows = rows
        
        print("called draw")
        
        for (start,end) in mutilChooseDate{
            
            let newInterval = CalendarUtil.shared.getIntervalWithBorders(from: start, to: end, withBorders: rows)
            
            if newInterval.count != 0{
                let interval = newInterval[0]
                print(interval.0.CNtoString)
                print(interval.1.CNtoString)
                drawNewMutil(startAt: interval.0, endAt: interval.1)
                
                let startMonthCell = mainView.calendar.cellForRow(at: IndexPath(row: CalendarUtil.shared.getMonthCellIndex(date: interval.0), section: 0)) as! MPCustomCalendarCell
                let startDayCell = startMonthCell.calendar.cellForItem(at: IndexPath(row: CalendarUtil.shared.getDayCellIndex(date: interval.0), section: 0)) as! MPCustomCalendarDayCell
                
                let endMonthCell = mainView.calendar.cellForRow(at: IndexPath(row: CalendarUtil.shared.getMonthCellIndex(date: interval.1), section: 0)) as! MPCustomCalendarCell
                let endDayCell = endMonthCell.calendar.cellForItem(at: IndexPath(row: CalendarUtil.shared.getDayCellIndex(date: interval.1), section: 0)) as! MPCustomCalendarDayCell
                
                if interval.0 != start{
                    startDayCell.handleMutilChooseUI(forStatus: true, isHead: false, isTail: false)
                }
                
                if interval.1 != end{
                    endDayCell.handleMutilChooseUI(forStatus: true, isHead: false, isTail: false)
                }
            }
            
        }
    }
    
}
