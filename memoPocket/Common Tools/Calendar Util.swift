//
//  Calendar Util.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/4.
//  Copyright © 2020 Macsed. All rights reserved.
//

import Foundation

class CalendarUtil {
    
    private let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()
    
    private let daysOfMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    func getMonthDayCount(ofYear year : Int,ofMonth month : Int) -> Int{
        
        var count = daysOfMonth[month]
        
        if (year%4==0 && year%100 != 0) || year%400 == 0{
            if month == 2{
                count = 29
            }
        }
        
        return count
    }
    
    static let shared = CalendarUtil()
    
    func getCellCount(ofYear year : Int,ofMonth month : Int) -> Int{
        if let date = formatter.date(from: "\(year)-\(month)-01"){
            let calendar = Calendar.current
            let components = calendar.dateComponents(in: .current, from: date)
            if let weekday = components.weekday{
                return weekday + getMonthDayCount(ofYear: year, ofMonth: month) - 1
            }else{
                fatalError("创建日历时无法计算weekday")
            }
            
        }else{
            fatalError("创建日历选项时遇见错误的日期")
        }
    }
    
    
}
