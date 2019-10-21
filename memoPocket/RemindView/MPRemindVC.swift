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
    var scrollStatus : scrollDirection = .up
    
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
            return (124)
        }
        return CGFloat(102)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RemindCell(title:"Title" ,time:"time" ,from:"One" ,color: .red)
        let count = tableView.numberOfRows(inSection: 0)
        if indexPath.row == count-1{
            cell.content!.snp.updateConstraints{(make) in
                make.centerY.equalToSuperview().offset(-11)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let recognizer = scrollView.panGestureRecognizer
        let offsetY = recognizer.translation(in: scrollView).y
        if offsetY > 0 && scrollStatus == .down{
            print("Dragging up process")
            scrollStatus = .processing
            rootTabbarVC!.showConstraints()
            rootTabbarVC!.tabbarVC.tabbar.show()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.scrollStatus = .up
                print("Dragging up done")
            }
        }else if offsetY < 0 && scrollStatus == .up{
            print("Dragging down process")
            scrollStatus = .processing
            rootTabbarVC!.tabbarVC.tabbar.dissmiss()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                rootTabbarVC!.dissmissConstraints()
                self.scrollStatus = .down
                print("Dragging down done")
            }
        }
            
            
    //        print("offset is \(scrollView.contentOffset)")
            
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("offset is \(scrollView.contentOffset)")
        if (scrollView.contentOffset == CGPoint(x: 0.0, y: 0.0)){
            while scrollStatus == .processing {
                
            }
            if scrollStatus == .down {
                scrollStatus = .processing
                rootTabbarVC!.showConstraints()
                rootTabbarVC!.tabbarVC.tabbar.show()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    self.scrollStatus = .up
                    print("after drag back up done")
                }
            }
        }
    }
    
}
