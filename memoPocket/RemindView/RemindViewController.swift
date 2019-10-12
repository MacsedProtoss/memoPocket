//
//  RemindViewController.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import JTAppleCalendar
class remindViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var remindview :UITableView?
    let cal = calendarView()
    var titles = ["图层 9","图层 8","图层 7"]
    let screensize = UIScreen.main.bounds
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102/812*screensize.height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let width = screensize.width * 355/375
        let height = screensize.height * 102/812
        let cell = remindCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
        cell.imageofcell?.image = UIImage(named: titles[indexPath.row])?.reSetSize(Size: CGSize(width: width, height: height))
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil, handler: { (action, view, completionHandler) in
            
            completionHandler(true)
            })
        delete.image = UIImage(named: "图层 17")?.reSetSize(Size: CGSize(width: 77/375*screensize.width, height: 94/812*screensize.height))
        delete.backgroundColor = getColor(hexValue: 0xEDEFF4)
        let edit = UIContextualAction(style: .normal, title: nil, handler: { (action, view, completionHandler) in
            
            completionHandler(true)
        })
        edit.image = UIImage(named: "图层 18")?.reSetSize(Size: CGSize(width: 69/375*screensize.width, height: 94/812*screensize.height))
        edit.backgroundColor = getColor(hexValue: 0xEDEFF4)
        let configuration = UISwipeActionsConfiguration(actions: [edit,delete])
        return configuration
    }
    func getColor(hexValue: UInt64) -> UIColor {
        let red = CGFloat(Double((hexValue & 0xFF0000)>>16)/255.0)
        let green = CGFloat(Double((hexValue & 0x00FF00)>>8)/255.0)
        let blue = CGFloat(Double(hexValue & 0x0000FF)/255.0)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    
    func calendar(){
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remindview = UITableView(frame: CGRect(x: 0, y: screensize.height * 266/812, width: 0, height: 0))
        remindview?.frame.size = CGSize(width: screensize.width*365/375 , height: screensize.height * 306/812)
        remindview?.backgroundColor = getColor(hexValue: 0xEDEFF4)
        remindview?.delegate = self
        remindview?.dataSource = self
        remindview?.separatorStyle = .none
        remindview?.register(remindCell.classForCoder(), forCellReuseIdentifier: "cell")
        remindview?.allowsSelection = false
        let timeview = UIView()
        timeview.backgroundColor = getColor(hexValue: 0xEDEFF4)
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy年MM月dd日"
        let today = dateFormat.string(from: date)
//        let todayLabel = UILabel(frame: CGRect(x: 41/375*screensize.width, y: 158/812*screensize.height, width: 111/375*screensize.width, height: 15/812*screensize.height))
//        todayLabel.text = today
        let todayLabel = UIImageView(frame: CGRect(x: 41/375*screensize.width, y: 158/812*screensize.height, width: 111/375*screensize.width, height: 15/812*screensize.height))
        todayLabel.image = UIImage(named: "图层 14")?.reSetSize(Size: CGSize( width: 111/375*screensize.width, height: 15/812*screensize.height))
        //        todayLabel.text = today
        dateFormat.dateFormat = "HH:mm"
        let time = dateFormat.string(from: date)
//        let timeLabel = UILabel(frame: CGRect(x: 42/375*screensize.width, y: 100/812*screensize.height, width: 124/375*screensize.width, height: 38/812*screensize.height))
//        timeLabel.text = time
        let timeLabel = UIImageView(frame: CGRect(x: 42/375*screensize.width, y: 100/812*screensize.height, width: 124/375*screensize.width, height: 38/812*screensize.height))
        timeLabel.image = UIImage(named: "图层 15")?.reSetSize(Size: CGSize( width: 124/375*screensize.width, height: 38/812*screensize.height))
        let changeDate = UIButton(frame:  CGRect(x: 165/375*screensize.width, y: 157/812*screensize.height, width: 80/375*screensize.width, height: 17/812*screensize.height))
        let tempimage = UIImage(named: "图层 13")?.reSetSize(Size: CGSize(width: 80/375*screensize.width, height: 17/812*screensize.height))
        changeDate.setImage(tempimage, for: .normal)
        changeDate.addTarget(self, action: #selector(pushCalendar), for: .touchUpInside)
        
        let addButton = UIButton(frame: CGRect(x: 298/375*screensize.width, y: 576/812*screensize.height, width: 56/375*screensize.width, height: 56/812*screensize.height))
        addButton.setImage(UIImage(named: "图层 16")?.reSetSize(Size: CGSize(width: 56/375*screensize.width, height: 56/812*screensize.height)), for: .normal)
        let tapAddButton = UITapGestureRecognizer(target: self, action: #selector(newSchedule))
        addButton.addGestureRecognizer(tapAddButton)
        

        let back = UIImageView(image:UIImage(named: "图层 2")?.reSetSize(Size: CGSize(width: screensize.width, height: 170/812*screensize.height)))
        back.frame = CGRect(x: 0, y: 641/812*screensize.height, width: screensize.width, height: 170/812*screensize.height)

        // 隐藏NavigationBar
        let navigationBar = self.navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true

        self.view.addSubview(timeview)
        self.view.addSubview(remindview!)
        self.view.addSubview(back)
        self.view.addSubview(changeDate)
        self.view.addSubview(addButton)
        self.view.addSubview(todayLabel)
        self.view.addSubview(timeLabel)
        notuseful()
        timeview.snp.makeConstraints{
            (make)  -> Void in
            make.width.equalTo(screensize.width)
            make.height.equalTo(266/812*screensize.height)
            make.top.equalTo(0)
            make.bottom.equalTo(546/812*screensize.height)
        }
        timeview.layoutIfNeeded()
    }
    
    func notuseful(){
        
        let text1  = UIImageView(frame: CGRect(x: 41/375*screensize.width, y: 227/812*screensize.height, width: 47/375*screensize.width, height: 15/812*screensize.height))
        let text1img = UIImage(named: "图层 10")?.reSetSize(Size: CGSize(width: 47/375*screensize.width, height: 15/812*screensize.height))
        text1.image = text1img
        
        
        self.view.addSubview(text1)
        let text2  = UIImageView(frame: CGRect(x: 140/375*screensize.width, y: 227/812*screensize.height, width: 47/375*screensize.width, height: 15/812*screensize.height))
        let text2img = UIImage(named: "图层 12")?.reSetSize(Size: CGSize(width: 47/375*screensize.width, height: 15/812*screensize.height))
        text2.image = text2img
        
        
        self.view.addSubview(text2)
        
        
        let text1line  = UIImageView(frame: CGRect(x: 38/375*screensize.width, y: 247/812*screensize.height, width: 50/375*screensize.width, height: 3/812*screensize.height))
        let text1imgline = UIImage(named: "6")?.reSetSize(Size: CGSize(width: 50/375*screensize.width, height: 3/812*screensize.height))
        text1line.image = text1imgline
        self.view.addSubview(text1line)
    }
    @objc func pushCalendar(){
        for i in (remindview?.visibleCells)!{
            i.backgroundColor = getColor(hexValue: 0xB8C2CC)
        }
        self.view.subviews[0].backgroundColor = getColor(hexValue: 0xB8C2CC)
        self.view.subviews[1].backgroundColor = getColor(hexValue: 0xB8C2CC)
        let pop = cal.view
        pop?.tag = 100
        self.view.addSubview(pop!)
        
    }
    
    @objc func newSchedule() {
        self.navigationController?.pushViewController(NewViewController(), animated: true)
    }
}

