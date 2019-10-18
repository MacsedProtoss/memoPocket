//
//  CalendarView.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import UIKit
import JTAppleCalendar

class calendarView:UIViewController,JTACMonthViewDelegate,JTACMonthViewDataSource{
    var calendarTitleLeft = ""
    var calendarTitleRight = ""
    func getColor(hexValue: UInt64) -> UIColor {
        let red = CGFloat(Double((hexValue & 0xFF0000)>>16)/255.0)
        let green = CGFloat(Double((hexValue & 0x00FF00)>>8)/255.0)
        let blue = CGFloat(Double(hexValue & 0x0000FF)/255.0)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate,numberOfRows: 6)
    }
    
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
       
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel?.text = cellState.text
        cell.dateLabel?.textColor = getColor(hexValue: 0x5D647F)
        cell.rightRect?.backgroundColor = getColor(hexValue: 0x88A3FF)
        cell.leftRect?.backgroundColor = getColor(hexValue: 0x88A3FF)
//        cell.dateLabel?.font = UIFont.systemFont(ofSize: )   pt CGFloat
        
        cell.dateLabel?.textAlignment = NSTextAlignment.center
//        cell.selectedView?.addSubview(UIImageView(image: UIImage(named: "日历21")?.reSetSize(Size: CGSize(width: 38/375*width, height: 38/812*height))))
        if cellState.dateBelongsTo == .thisMonth{
            cell.isHidden = false
        }else{
            cell.isHidden = true
        }
        if cellState.isSelected{
            cell.dateLabel?.highlightedTextColor = UIColor.white
        }else{
            cell.rightRect?.isHidden = true
            cell.leftRect?.isHidden = true
        }
        
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
        
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel?.textColor = UIColor.black
        } else {
            cell.dateLabel?.textColor = UIColor.gray
        }
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        cell.selectedView?.isHidden = !cellState.isSelected
        switch cellState.selectedPosition() {
        case .left:
//            cell.selectedView?.layer.cornerRadius = 10
//            cell.selectedView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            cell.rightRect?.isHidden = false
            
        case .middle:
//            cell.selectedView?.layer.cornerRadius = 0
            cell.leftRect?.isHidden = false
            cell.rightRect?.isHidden = false
        case .right:
              cell.leftRect?.isHidden = false
//            cell.selectedView?.layer.cornerRadius = 10
//            cell.selectedView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
//        case .full:
//            cell.leftRect?.isHidden = false
//            cell.rightRect?.isHidden = false
//            cell.selectedView?.layer.cornerRadius = 10
//            cell.selectedView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        default: break
        }
    }
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        cell.frame.size = CGSize(width: screensize.width*38/375, height: screensize.height*38/812)
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    let screensize = UIScreen.main.bounds
    let testCalendar = Calendar(identifier: .gregorian)
    var calView = JTACMonthView()
    
    override func viewDidLoad() {
        self.view.frame = CGRect(x: 17/375*screensize.width, y: 179/812*screensize.height, width: 341/375*screensize.width, height: 510/812*screensize.height)
        
        let bgView = UIImageView(frame: CGRect(x: -3, y: 0, width: 341/375*screensize.width, height: 510/812*screensize.height))
        bgView.image = UIImage(named: "日历 18")?.reSetSize(Size: CGSize(width: 341/375*screensize.width, height: 510/812*screensize.height))
        let backbtn = UIButton(frame: CGRect(x: 17/375*screensize.width, y: 16/812*screensize.height, width: 11/375*screensize.width, height: 17/812*screensize.height))
        backbtn.addTarget(self, action: #selector(removeCalendar), for: .touchUpInside)
        backbtn.setImage(UIImage(named: "日历 20")?.reSetSize(Size: CGSize(width: 11/375*screensize.width, height: 17/812*screensize.height)), for: .normal)
        let confirmbtn = UIButton(frame: CGRect(x: 38/375*screensize.width, y: 446/812*screensize.height, width: 265/375*screensize.width, height: 48/812*screensize.height))
        confirmbtn.setImage(UIImage(named: "日历 19")?.reSetSize(Size: CGSize(width: 265/375*screensize.width, height: 48/812*screensize.height)), for: .normal)
        let weekview = UIImageView(frame:CGRect(x:-3, y: 0, width: 341/375*screensize.width, height: 114/812*screensize.height))
        weekview.image = UIImage(named: "日历 25")?.reSetSize(Size: CGSize(width: 341/375*screensize.width, height: 114/812*screensize.height))
        weekview.backgroundColor = getColor(hexValue: 0xB9C2CC)
        calView.frame = CGRect(x: -3, y: 88/812*screensize.height, width: 341/375*screensize.width, height: 306/812*screensize.height)
        calView.isHidden = false
        calView.allowsMultipleSelection = true
        calView.allowsRangedSelection = true
        calView.scrollingMode = ScrollingMode.stopAtEachCalendarFrame
        calView.calendarDelegate = self as! JTACMonthViewDelegate
        calView.calendarDataSource = self
        calView.register(DateCell.self, forCellWithReuseIdentifier: "dateCell")
        calView.backgroundColor = getColor(hexValue: 0xF7F8F9)
        self.view.backgroundColor = getColor(hexValue: 0xB9C2CC)

        self.view.addSubview(bgView)
        self.view.addSubview(weekview)
        self.view.addSubview(calView)
        self.view.addSubview(confirmbtn)
        self.view.addSubview(backbtn)
    }
    @objc func removeCalendar(){//maybe still some problems
//        for view in self.view.subviews{
//            if view.tag == 100{
//                view.removeFromSuperview()
//            }
//        }
       
        self.view.superview?.subviews[0].backgroundColor = getColor(hexValue: 0xEDEFF4)
        self.view.superview?.subviews[1].backgroundColor = getColor(hexValue: 0xEDEFF4)
        let temp = self.view.superview?.subviews[1] as! UITableView
        for i in (temp.visibleCells){
         i.backgroundColor = getColor(hexValue: 0xEDEFF4)
        }
      print(self.view.superview?.subviews)
        self.view.removeFromSuperview()
      
    }
    @objc func didStartRangeSelecting(gesture:UILongPressGestureRecognizer){
        let point = gesture.location(in: gesture.view!)
        let rangeSelectedDates = calView.selectedDates
        
        guard let cellState = calView.cellStatus(at: point) else { return }
        
        if !rangeSelectedDates.contains(cellState.date) {
            let dateRange = calView.generateDateRange(from: rangeSelectedDates.first ?? cellState.date, to: cellState.date)
            calView.selectDates(dateRange, keepSelectionIfMultiSelectionAllowed: true)
        } else {
            let followingDay = testCalendar.date(byAdding: .day, value: 1, to: cellState.date)!
            calView.selectDates(from: followingDay, to: rangeSelectedDates.last!, keepSelectionIfMultiSelectionAllowed: false)
        }
    }
}

//extension ViewController: JTAppleCalendarViewDataSource {
//    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy MM dd"
//
//        let startDate = formatter.date(from: "2018 01 01")!
//        let endDate = Date()
//        return ConfigurationParameters(startDate: startDate, endDate: endDate)
//    }
//}
//
//extension ViewController: JTAppleCalendarViewDelegate {
//
//    func configureCell(view: JTAppleCell?, cellState: CellState) {
//        guard let cell = view as? DateCell  else { return }
//        cell.dateLabel?.text = cellState.text
//        handleCellTextColor(cell: cell, cellState: cellState)
//        handleCellSelected(cell: cell, cellState: cellState)
//    }
//
//    func handleCellTextColor(cell: DateCell, cellState: CellState) {
//        if cellState.dateBelongsTo == .thisMonth {
//            cell.dateLabel?.textColor = UIColor.black
//        } else {
//            cell.dateLabel?.textColor = UIColor.gray
//        }
//    }
//
//    func handleCellSelected(cell: DateCell, cellState: CellState) {
//        cell.selectedView?.isHidden = !cellState.isSelected
//        switch cellState.selectedPosition() {
//        case .left:
//            cell.selectedView?.layer.cornerRadius = 20
//            cell.selectedView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
//        case .middle:
//            cell.selectedView?.layer.cornerRadius = 0
//            cell.selectedView?.layer.maskedCorners = []
//        case .right:
//            cell.selectedView?.layer.cornerRadius = 20
//            cell.selectedView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
//        case .full:
//            cell.selectedView?.layer.cornerRadius = 20
//            cell.selectedView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
//        default: break
//        }
//    }
//    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
//        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
//        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
//        return cell
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
//        configureCell(view: cell, cellState: cellState)
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        configureCell(view: cell, cellState: cellState)
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        configureCell(view: cell, cellState: cellState)
//    }
//}







