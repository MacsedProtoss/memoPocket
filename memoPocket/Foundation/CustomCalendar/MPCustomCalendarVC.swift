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
    private var backGroundImage : UIImage?
    
    convenience init(type : CalendarType,backGroundImage : UIImage?){
        self.init()
        self.type = type
        self.backGroundImage = backGroundImage
    }
    
    override func viewDidLoad() {
        getView()
        mainView.backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
    }
    
    func getView(){
        mainView = MPCustomCalendarView(backgroundImage: backGroundImage)
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    @objc func backBtnPressed(){
        self.dismiss(animated: false, completion: nil)
    }
}
