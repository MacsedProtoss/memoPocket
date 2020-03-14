//
//  MPCustomInputPureTextCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/3/4.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomInputPureTextCell : MPCustomInputBaseCell,UITextViewDelegate{
    
    var inputText : UITextView!
    private var lastSize = CGSize.zero
    
    convenience init(withTitle title: String, withHint hint: String) {
        self.init()
        getView(withTitle: title ,withHint: hint, hasFold: false)
    }
    
    override func getView(withTitle title: String, withHint hint: String, hasFold isFold: Bool) {
        getBasicView(withTitle: title)
        getText()
        getHint(withHint: hint)
    }
    
    @objc func hintPressed(){
        inputText.becomeFirstResponder()
    }
    
    override func getHint(withHint hint: String) {
        super.getHint(withHint: hint)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hintPressed))
        hintLabel.isUserInteractionEnabled = true
        hintLabel.addGestureRecognizer(tapRecognizer)
    }
    
    private func getText(){
        
        inputText = {
            let text = UITextView()
            text.delegate = self
            text.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.reSized)
            text.textColor = getColor(hexValue: 0x686E83, alpha: 0.8)
            text.textAlignment = .left
            text.backgroundColor = .clear
            mainLayer.addSubview(text)
            text.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(24.reSized)
                make.top.equalToSuperview().offset(15.reSized)
                make.trailing.equalToSuperview().offset(-32.reSized)
                make.height.equalTo(28.reSized)
            }
            text.showsVerticalScrollIndicator = false
            text.showsHorizontalScrollIndicator = false
            text.textContainerInset = .zero
            return text
        }()
        
        let _ : UIToolbar = {
            let bar = UIToolbar()
            bar.frame = CGRect(x: 0, y: 0, width: screensize.width, height: 40.reSized)
            let doneBtn = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(finishedInput))
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            bar.items = [space,doneBtn]
            inputText.inputAccessoryView = bar
            return bar
        }()
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == ""{
            hintLabel.isHidden = false
        }else{
            hintLabel.isHidden = true
        }

        
        let size = inputText.contentSize
        
        if size != lastSize{
            inputText.snp.updateConstraints { (make) in
                make.height.equalTo(size.height)
            }

            mainLayer.snp.updateConstraints { (make) in
                make.height.equalTo(size.height + 29.reSized)
            }

            delegate?.updateHeight(withCell:self,to:(29+38+31+4).reSized + size.height)
            
        }

        lastSize = size
    }
    
    @objc func finishedInput(){
        inputText.endEditing(true)
    }
    
}
