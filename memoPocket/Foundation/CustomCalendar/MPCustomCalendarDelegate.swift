//
//  MPCustomCalendarDelegate.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/2.
//  Copyright © 2020 Macsed. All rights reserved.
//

import Foundation

protocol MPCustomCalendarDelegate {
    func calendarViewDismiss()
    func changeDateTo(date : Date)
    func changeDatesTo(dates : [Date])
}
