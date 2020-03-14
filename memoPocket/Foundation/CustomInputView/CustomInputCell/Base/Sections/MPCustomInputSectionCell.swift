//
//  MPCustomInputSectionCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/3/12.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomInputSectionCell : UITableViewCell{
    
    private var sectionLabel : UILabel!
    private var checkImg : UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(with section : String){
        self.init()
        getSection(with: section)
        getCheck()
    }
    
    private func getSection(with section : String){
        let label = UILabel()
        
        label.text = section
        label.textColor = getColor(hexValue: 0x686E83, alpha: 0.8)
        label.textAlignment = .left
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 20.reSized)
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(33.reSized)
            make.centerY.equalToSuperview()
            make.height.equalTo(28.reSized)
            make.width.equalToSuperview().dividedBy(1.5)
        }
        
        sectionLabel = label
    }
    
    private func getCheck(){
        let image = UIImageView()
        image.image = UIImage.init(systemName: "checkmark")?.reSetSize(Size: CGSize(width: 22.reSized, height: 18.reSized)).withTintColor(getColor(hexValue: 0x686E83, alpha: 0.8), renderingMode: .alwaysOriginal)
        self.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.width.equalTo(22.reSized)
            make.height.equalTo(18.reSized)
            make.trailing.equalToSuperview().offset(-20.reSized)
            make.centerY.equalToSuperview()
        }
        image.isHidden = true
        
        checkImg = image
    }
    
    func changeStatus(to status: Bool){
        if status{
            checkImg.isHidden = false
        }else{
            checkImg.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
