//
//  MPCustomInputDatePickCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/3/10.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomInputDatePickCell : MPCustomInputBaseCell,UITextFieldDelegate{

    private var isFold = true
    var picker : UIDatePicker!
    
    convenience init (withTitle title : String,withHint hint:String){
        self.init()
        getView(withTitle: title ,withHint: hint, hasFold: true)
        getPicker()
        foldBtn.addTarget(self, action: #selector(foldPressed), for: .touchUpInside)
    }
    
    private func getPicker(){
        let p = UIDatePicker()
        p.locale = Locale(identifier: "zh")
        p.datePickerMode = .dateAndTime
        p.setDate(Date(), animated: true)
        p.minimumDate = Date()
        p.addTarget(self, action: #selector(handlePickerEvent), for: .valueChanged)
        
        p.tintColor = getColor(hexValue: 0x686E83, alpha: 1)
        p.setValue(getColor(hexValue: 0x686E83, alpha: 0.8), forKey: "textColor")
        p.setValue(false, forKey: "highlightsToday")
        
        
        mainLayer.addSubview(p)
        p.snp.makeConstraints { (make) in
            make.top.equalTo(hintLabel.snp.bottom).offset(13.reSized)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(208.reSized)
        }
        
        picker = p
    }
    
    @objc func handlePickerEvent(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd  HH:mm"
        hintLabel.text = formatter.string(from: picker.date)
    }
    
    @objc func foldPressed(){
        if isFold{
            showPicker()
        }else{
            dismissPicker()
        }
    }
    
    private func showPicker(){
        
        mainLayer.snp.updateConstraints { (make) in
            make.height.equalTo((57+208).reSized)
        }
        
        delegate?.updateHeight(withCell: self, to: (130+208).reSized)
        
        foldBtn.setImage(UIImage.init(systemName: "checkmark")?.reSetSize(Size: CGSize(width: 22.reSized, height: 18.reSized)).withTintColor(getColor(hexValue: 0x686E83, alpha: 0.8), renderingMode: .alwaysOriginal), for: .normal)
        isFold = false
    }
    
    private func dismissPicker(){
     
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.25) {
            self.mainLayer.snp.updateConstraints { (make) in
                make.height.equalTo((57).reSized)
            }
        }
        
        delegate?.updateHeight(withCell: self, to: (130).reSized)
        
        foldBtn.setImage(UIImage.init(systemName: "chevron.down")?.reSetSize(Size: CGSize(width: 20.reSized, height: 14.reSized)).withTintColor(getColor(hexValue: 0x686E83, alpha: 0.8), renderingMode: .alwaysOriginal), for: .normal)
        isFold = true
    }
}
