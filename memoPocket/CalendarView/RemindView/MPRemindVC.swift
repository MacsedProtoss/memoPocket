//
//  RemindVC.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/17.
//  Copyright © 2019 Macsed. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RemindVC: MainDynamicTabVC,UITableViewDataSource,MPCustomCalendarDelegate {
    
    func calendarViewDismiss() {
        maskView.removeFromSuperview()
        calendarVC?.view.removeFromSuperview()
    }
    
    func changeDateTo(date: Date) {
        //
    }
    
    func changeDatesTo(dates: [Date]) {
        //
    }
    
    
    var mainView : RemindView!
    var calendarVC : MPCustomCalendarVC?
    private let maskView : UIView = {
        let mask = UIView()
        mask.backgroundColor = getColor(hexValue: 0x404F6A, alpha: 0.28)
        return mask
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = self.navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        mainView = getMainView()
        
        
    }
    
    func getMainView() -> RemindView {
        let mainView = RemindView()
        view.addSubview(mainView)
        mainView.snp.makeConstraints{(make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        for index in 0..<2 {
            mainView.tables[index].delegate = self
            mainView.tables[index].dataSource = self
            mainView.tables[index].register(RemindCell.classForCoder(), forCellReuseIdentifier: "cell")
        }
        
        
        for section in mainView.switcher.sections {
            section.addTarget(self, action: #selector(handleSection(_:)), for: .touchUpInside)
        }
        
        mainView.calendarBtn.addTarget(self, action: #selector(handleChangeDate), for: .touchUpInside)
        
        return mainView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("section is \(section)")
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = tableView.numberOfRows(inSection: 0)
//        print("count is \(count)")
//        print("indexPath is \(indexPath.row)")
        if indexPath.row == count-1{
            return (164)
        }
        return CGFloat(102)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RemindCell(title:"Title" ,time:"time" ,from:"One" ,color: .red)
        let count = tableView.numberOfRows(inSection: 0)
        if indexPath.row == count-1{
            cell.content!.snp.updateConstraints{(make) in
                make.centerY.equalToSuperview().offset(-31)
            }
        }
        return cell
    }
    
    @objc func handleSection(_ sender:UIButton){
        let toIndex = sender.tag
        mainView!.switcher.moveStatus(from: mainView!.switcher.selectedIndex, to: toIndex)
        mainView!.swithContent(from: mainView!.switcher.selectedIndex, to: toIndex)
        mainView!.switcher.selectedIndex = toIndex
        
    }
    
    @objc func handleChangeDate(){
        
        calendarVC = MPCustomCalendarVC(type: .single)
        calendarVC?.delegate = self
        
        keyWindow?.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        keyWindow?.addSubview(calendarVC!.view)
        calendarVC!.view.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
}
