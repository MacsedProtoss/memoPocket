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
import JTAppleCalendar
class RemindVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var mainView : RemindView? = nil
    
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
            make.bottom.equalToSuperview().offset(88)
        }
        
        for index in 0..<2 {
            mainView.tables[index].delegate = self
            mainView.tables[index].dataSource = self
            mainView.tables[index].register(remindCell.classForCoder(), forCellReuseIdentifier: "cell")
        }
        
        
        for section in mainView.switcher.sections {
            section.addTarget(self, action: #selector(handleSection(_:)), for: .touchUpInside)
        }
        
        return mainView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(102)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let width = CGFloat(355)
        let height = CGFloat(105)
        let cell = remindCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        return cell
    }
    
    @objc func handleSection(_ sender:UIButton){
        let toIndex = sender.tag
        mainView!.switcher.moveStatus(from: mainView!.switcher.selectedIndex, to: toIndex)
        mainView!.swithContent(from: mainView!.switcher.selectedIndex, to: toIndex)
        mainView!.switcher.selectedIndex = toIndex
        
    }
    
    
    
}
