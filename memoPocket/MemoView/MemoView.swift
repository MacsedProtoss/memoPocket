//
//  MemoView.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/17.
//  Copyright © 2019 Macsed. All rights reserved.
//


// TODO


import UIKit

class MemoView : UIView {
    
    let headView : UIView = UIView()
    let timeSelection : UIView = UIView()
    let memberList : UICollectionView = UICollectionView()
    let sections : [UIButton] = []
    
    var btnList : [String] = []
    
    convenience init(btnList : [String]){
        let rect = CGRect(x: 0, y: 0, width: screensize.width, height: 69)
        self.init(frame:rect)
    }
    
    
    
    
    
}
