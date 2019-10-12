//
//  SegamentViewController.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class segementViewController: UIView,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func initView(){
        let screensize = UIScreen.main.bounds
        let width = screensize.width
        let height = screensize.height
        let segementView = segementViewController(frame: CGRect(x: 0, y: 0, width: 24/812*width, height: 204/375*height))
        segementView.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2))
        
    }
    
}

