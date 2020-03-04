//
//  Cache.swift
//  memoPocket
//
//  Created by Macsed on 2020/3/4.
//  Copyright © 2020 Macsed. All rights reserved.
//

import Foundation
import UIKit

struct MPCustomCalendarCache {
    var data : [MPCustomeCalendarMonthData]
}

struct MPCustomeCalendarMonthData {
    var year : Int
    var month : Int
    var firstDay : Int
    var height : CGFloat
    var data : [MPCustomeCalendarDayData]
}

struct MPCustomeCalendarDayData{
    var isToday : Bool
    var year : Int
    var month : Int
    var day : Int
}

struct MPCustomCalendarDayCellConstant {
    var base : CGFloat
    var reSized40 : CGFloat
    var reSized20 : CGFloat
}

let MPCustomCalendarDayCellCache = MPCustomCalendarDayCellConstant(base: (380.0/7).reSized, reSized40: 40.reSized, reSized20: 20.reSized)

class MPCustomCalendarCacheBuilder{
    
    static let lock = NSObject()
    
    static var CalendarCache : MPCustomCalendarCache{
        get{
            objc_sync_enter(lock)
            let output = _CalendarCache
            objc_sync_exit(lock)
            return output
        }
        set{
            objc_sync_enter(lock)
            _CalendarCache = newValue
            objc_sync_exit(lock)
        }
    }
    
    private static var _CalendarCache : MPCustomCalendarCache = MPCustomCalendarCache(data: [])
    
    static func GetCache(){
        DispatchQueue.global().async {
            var output = MPCustomCalendarCache(data: [])
            
            for row in 0..<36{
                let month = (CalendarUtil.shared.getStartMonth() + row)%12==0 ? 12 : (CalendarUtil.shared.getStartMonth() + row)%12
                let year = CalendarUtil.shared.getStartYear() + ((CalendarUtil.shared.getStartMonth() + row)%12 == 0 ? (CalendarUtil.shared.getStartMonth() + row - 1)/12 : (CalendarUtil.shared.getStartMonth() + row)/12)
                let count = CalendarUtil.shared.getCellCount(ofYear: year, ofMonth: month)
                
                let height = 49.reSized + CGFloat(count/7 + 1)*40.reSized + CGFloat(count/7)*16.reSized + 31.reSized
                
                let firstDay = CalendarUtil.shared.getFirstDayOfMonth(ofYear: year, ofMonth: month)
                
                var temp = MPCustomeCalendarMonthData(year: year, month: month, firstDay: firstDay, height: height, data: [])
                
                for day in 1...count{
                    let isToday = CalendarUtil.shared.isToday(ofYear: year, ofMonth: month, ofDay: day)
                    let dayData = MPCustomeCalendarDayData(isToday: isToday, year: year, month: month, day: day)
                    temp.data.append(dayData)
                }
                
                output.data.append(temp)
                
            }
            
            CalendarCache = output
            
        }
    }
    
}
