//
//  DateCell.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import UIKit
import JTAppleCalendar
class DateCell: JTACDayCell {
    var dateLabel: UILabel?
    var selectedView: UIView?
    var image:UIImageView?
    var leftRect:UIView?
    var rightRect:UIView?
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    override init(frame: CGRect) {
        super.init(frame:frame)
        leftRect = UIView(frame: CGRect(x: -12/375*width/2-10, y: 0, width: 57/375*width/2, height: 45/812*height))
        rightRect = UIView(frame: CGRect(x:45/375*width/2-10, y: 0, width: 50/375*width/2, height: 45/812*height))
        leftRect?.isHidden = true
        rightRect?.isHidden = true
        dateLabel = UILabel()
        dateLabel?.frame = CGRect(x: -10, y: 0, width: 45/375*width, height: 45/812*height)
        selectedView = UIView()
        selectedView?.frame = CGRect(x: -10, y: 0, width: 55/375*width, height: 45/812*height)
        image = UIImageView(image: UIImage(named: "圆")?.reSetSize(Size: CGSize(width: 45/375*width, height: 45/812*height)))
        
        selectedView?.addSubview(image!)
        
        self.frame = CGRect(x: -18, y: 0, width: 55/375*width, height: 45/812*height)
        self.addSubview(rightRect!)
        self.addSubview(leftRect!)
        self.addSubview(selectedView!)
        self.addSubview(dateLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

