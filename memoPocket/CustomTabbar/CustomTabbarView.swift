//
//  CustomTabbarView.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import UIKit
import SnapKit

let screensize = UIScreen.main.bounds


class CustomTabbarView : UIView {
    
    
    var numOfSection : Int = 0
    
    private let sizeBict : Dictionary<String,CGSize> = ["memoBtn":CGSize(width: 24, height: 36),"remindBtn":CGSize(width: 23, height: 42),"infoBtn":CGSize(width: 23, height: 38)]
    
    private let btnList = ["memoBtn","remindBtn","infoBtn"]
    
    var seletedIndex = 0
    
    private var sections : [UIButton] = []
    private var backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         
    }
    
    convenience init (num : Int){
        let rect = CGRect(x: 0, y: 0, width: screensize.width, height: 85)
        self.init(frame: rect)
        self.numOfSection = num
        backgroundView = getBackground()
        for index in 1...numOfSection{
            let btn = getButton(imageName: btnList[index - 1], index: index)
            sections.append(btn)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func getBackground() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor(red: 0.78, green: 0.81, blue: 0.88, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4.5)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 7.5
        view.layer.cornerRadius = 33
        
        self.addSubview(view)
        view.snp.makeConstraints{(make) in
            make.leading.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().offset(-11)
            make.centerY.equalToSuperview()
            make.height.equalTo(66)
            
        }
        
        return view
    }
    
    private func getButton(imageName:String,index:Int) -> UIButton {
        let btn = UIButton()
        btn.bounds.size = CGSize(width: screensize.width/CGFloat(numOfSection), height: 85)
        btn.setImage(UIImage(named: imageName)?.reSetSize(Size: sizeBict[imageName]!).withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: (sizeBict[imageName]!.height - sizeBict[btnList[0]]!.height)/2, right: 0)
        self.addSubview(btn)
        btn.snp.makeConstraints{(make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(Int(screensize.width)/numOfSection*(index - 1))
            make.width.equalTo(screensize.width/CGFloat(numOfSection))
        }
        return btn
    }
    
}
