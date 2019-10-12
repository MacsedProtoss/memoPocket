//
//  MemoViewController.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import Foundation
import UIKit
class memoViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    var titles = [["10","12","13"],["16","17","18"]]
    var months = ["9","14"]
    let screensize = UIScreen.main.bounds
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75/812*screensize.height
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailView()
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memoCell(frame: CGRect(x: 37/375*screensize.width, y: 0, width: screensize.width, height: 44/812*screensize.height))
        cell.selectionStyle = .none
        cell.linebelow?.image = UIImage(named: "11")
        
        cell.lineabove?.image = UIImage(named: "11")
        
        cell.linebelow?.frame = CGRect(x: 43/375*screensize.width, y: 15/812*screensize.height, width: 2/375*screensize.width, height: 64/812*screensize.height)
        cell.lineabove?.frame = CGRect(x: 43/375*screensize.width, y: 0, width: 2/375*screensize.width, height: 2/812*screensize.height)
        if indexPath.row == 0 {
            cell.lineabove?.isHidden = true
        }
        if indexPath.row == titles[indexPath.section].count-1 && indexPath.section != titles.count-1{
            cell.linebelow?.isHidden = true
        }
        let tempImage = UIImage(named: titles[indexPath.section][indexPath.row])
        let scale = (tempImage?.size.width)!/(tempImage?.size.height)!
        cell.imageofcell?.image = tempImage?.reSetSize(Size: CGSize( width: 44/812*screensize.height*scale, height: 44/812*screensize.height))
        cell.imageofcell?.frame = CGRect(x: 37/375*screensize.width, y: 0, width: 44/812*screensize.height*scale, height: 44/812*screensize.height)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 55/375*screensize.width, height: 43/812*screensize.height))
        view.backgroundColor = getColor(hexValue: 0xEDEFF4)
        let images =  UIImageView(image: UIImage(named: months[section])?.reSetSize(Size: CGSize(width: 55/375*screensize.width, height: 17/812*screensize.height)))
        images.frame = CGRect(x: 23/375*screensize.width, y: 0, width: images.frame.width, height: images.frame.height)
        view.addSubview(images)
        return view
    }
    func getColor(hexValue: UInt64) -> UIColor {
    let red = CGFloat(Double((hexValue & 0xFF0000)>>16)/255.0)
    let green = CGFloat(Double((hexValue & 0x00FF00)>>8)/255.0)
    let blue = CGFloat(Double(hexValue & 0x0000FF)/255.0)
    let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    return color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = getColor(hexValue: 0xEDEFF4)
        let memoView = UITableView(frame: CGRect(x: 0, y: 180/812*screensize.height, width: screensize.width, height: screensize.height),style: .grouped)
        memoView.backgroundColor = getColor(hexValue: 0xEDEFF4)
        memoView.delegate = self
        memoView.dataSource = self
        memoView.allowsMultipleSelection = false
        memoView.allowsSelection = true
        
        memoView.separatorStyle = .none
        memoView.isEditing = false
        memoView.register(memoCell.self, forCellReuseIdentifier: "memoCell")
        memoView.sectionHeaderHeight = 43/812*screensize.height
        let back = UIImageView(image:UIImage(named: "图层 2")?.reSetSize(Size: CGSize(width: screensize.width, height: 170/812*screensize.height)))
        back.frame = CGRect(x: 0, y: 641/812*screensize.height, width: screensize.width, height: 170/812*screensize.height)
        
        self.view.addSubview(memoView)
        self.view.addSubview(back)
        somethingnotHappen()
        
    }
    func somethingnotHappen(){
        let bg = UIImageView(frame: CGRect(x: 17/375*screensize.width, y: 46/812*screensize.height, width: 342/375*screensize.width, height: 63/812*screensize.height))
        let bgImg = UIImage(named: "2")?.reSetSize(Size: CGSize(width: 342/375*screensize.width, height: 63/812*screensize.height))
        bg.image = bgImg
        let bgtext  = UIImageView(frame: CGRect(x: 43/375*screensize.width, y: 65/812*screensize.height, width: 93/375*screensize.width, height: 17/812*screensize.height))
        let bgtextimg = UIImage(named: "3")?.reSetSize(Size: CGSize(width: 93/375*screensize.width, height: 17/812*screensize.height))
        bgtext.image = bgtextimg
        
        
        
        let text1  = UIImageView(frame: CGRect(x: 40/375*screensize.width, y: 126/812*screensize.height, width: 37/375*screensize.width, height: 17/812*screensize.height))
        let text1img = UIImage(named: "5")?.reSetSize(Size: CGSize(width: 37/375*screensize.width, height: 17/812*screensize.height))
        text1.image = text1img
        
        
        self.view.addSubview(text1)
        
        
        let text1line  = UIImageView(frame: CGRect(x: 38/375*screensize.width, y: 148/812*screensize.height, width: 40/375*screensize.width, height: 3/812*screensize.height))
        let text1imgline = UIImage(named: "6")?.reSetSize(Size: CGSize(width: 40/375*screensize.width, height: 3/812*screensize.height))
        text1line.image = text1imgline
        
        
        self.view.addSubview(text1line)
        
        let text2 = UIImageView(frame: CGRect(x: 168/375*screensize.width, y: 126/812*screensize.height, width: 37/375*screensize.width, height: 17/812*screensize.height))
        let text2img = UIImage(named: "7")?.reSetSize(Size: CGSize(width: 37/375*screensize.width, height: 17/812*screensize.height))
        text2.image = text2img
        
        
        self.view.addSubview(text2)
        let text3 = UIImageView(frame: CGRect(x: 296/375*screensize.width, y: 126/812*screensize.height, width: 37/375*screensize.width, height: 17/812*screensize.height))
        let text3img = UIImage(named: "8")?.reSetSize(Size: CGSize(width: 37/375*screensize.width, height: 17/812*screensize.height))
        text3.image = text3img
        
        
        self.view.addSubview(text3)
        
        self.view.addSubview(bg)
        self.view.addSubview(bgtext)
    }
}

