//
//  MPCustomeInputBaseCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/3/4.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

protocol MPCustomInputCellDelegate {
    func updateHeight(withCell cell : MPCustomInputBaseCell, to height:CGFloat)
}

class MPCustomInputBaseCell : UITableViewCell {
    
    var foldBtn : UIButton!
    var hintLabel : UILabel!
    var mainLayer : UIView!
    var titleLabel : UILabel!
    
    var delegate : MPCustomInputCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(withTitle title : String,withHint hint : String,hasFold isFold : Bool){
        self.init()
        getView(withTitle: title ,withHint: hint, hasFold: isFold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func getView(withTitle title : String,withHint hint : String,hasFold isFold : Bool){
        getBasicView(withTitle: title)
        getHint(withHint: hint)
        if isFold{
            getFold()
        }
    }
    
    internal func getBasicView(withTitle title:String){
        self.backgroundColor = .clear
        titleLabel = {
            let label = UILabel()
            
            label.text = title + "："
            label.textAlignment = .left
            label.textColor = getColor(hexValue: 0x686E83, alpha: 1)
            label.font = UIFont.init(name: "PingFangSC-Regular", size: 20.reSized)
            
            self.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(46.reSized)
                make.top.equalToSuperview().offset(31.reSized)
                make.width.equalToSuperview()
                make.height.equalTo(28.reSized)
            }
            
            return label
        }()
        
        mainLayer = {
            let view = UIView()
            
            view.backgroundColor = .white
            view.layer.cornerRadius = 13.reSized
            view.layer.masksToBounds = true
            
            view.layer.shadowColor = getColor(hexValue: 0xD8DEEC, alpha: 0.8).cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 4.reSized)
            view.layer.shadowOpacity = 1
            view.layer.shadowRadius = 9.reSized
            
            self.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(22.reSized)
                make.trailing.equalToSuperview().offset(-22.reSized)
                make.height.equalTo(57.reSized)
                make.top.equalToSuperview().offset(69.reSized)
            }
            
            return view
        }()
        
        
    }
    
    
    internal func getHint(withHint hint:String){
        hintLabel = {
            let label = UILabel()
            
            label.text = hint
            label.textAlignment = .left
            label.textColor = getColor(hexValue: 0x686E83, alpha: 0.8)
            label.font = UIFont.init(name: "PingFangSC-Medium", size: 20.reSized)
            
            mainLayer.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(15.reSized)
                make.leading.equalToSuperview().offset(24.reSized)
                make.height.equalTo(28.reSized)
                make.trailing.equalToSuperview().offset(-32.reSized)
            }
            
            return label
        }()
    }
    
    internal func getFold(){
        foldBtn = {
            let btn = UIButton(type: .system)
            btn.setImage(UIImage.init(systemName: "chevron.down")?.reSetSize(Size: CGSize(width: 20.reSized, height: 14.reSized)).withTintColor(getColor(hexValue: 0x686E83, alpha: 0.8), renderingMode: .alwaysOriginal), for: .normal)
            
            mainLayer.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().offset(-21.reSized)
                make.top.equalToSuperview().offset(23.reSized)
                make.width.equalTo(20.reSized)
                make.height.equalTo(14.reSized)
            }
            
            return btn
        }()
    }
    
}
