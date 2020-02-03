//
//  MPCustomCalendarVC.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/2.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomCalendarVC : UIViewController{
    
    private var type : CalendarType = .single
    private var mainView : MPCustomCalendarView!
    var delegate : MPCustomCalendarDelegate?
    
    convenience init(type : CalendarType){
        self.init()
        self.type = type
    }
    
    override func viewDidLoad() {
        getView()
        mainView.backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        mainView.confirmBtn.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
    }
    
    func getView(){
        view.backgroundColor = .clear
        mainView = MPCustomCalendarView()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    @objc func backBtnPressed(){
        delegate?.calendarViewDismiss()
    }
    
    @objc func confirmPressed(){
        delegate?.changeDateTo(date: Date()) // TODO
        delegate?.calendarViewDismiss()
    }
}
