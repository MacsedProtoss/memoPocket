//
//  MPTableWithoutExtraLine.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/4.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit

class MPTableWithoutExtraLine: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame:frame,style:style)
        clearExtraLine()
    }
    
    func clearExtraLine(){
        let view = UIView()
        view.backgroundColor = UIColor.clear
        self.tableFooterView = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
