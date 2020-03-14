//
//  MPCustomInputSingleSelectionCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/3/10.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomInputSingleSelectionCell : MPCustomInputBaseCell,UITableViewDelegate,UITableViewDataSource{
    
    private var selectedIndex : Int? = nil
    internal var isFolded = true
    internal var sectionTable : UITableView!
    internal var sections : [String] = []
    
    convenience init(withTitle title : String,withHint hint : String,withSections sections:[String]){
        self.init()
        self.sections = sections
        getView(withTitle: title ,withHint: hint, hasFold: true)
        foldBtn.addTarget(self, action: #selector(foldPressed), for: .touchUpInside)
        getTable()
    }
    
    @objc func foldPressed(){
        if isFolded{
            showSelection()
        }else{
            dismissSelection()
        }
    }
    
    private func showSelection(){
        
        sectionTable.isHidden = false
        
        mainLayer.snp.updateConstraints { (make) in
            make.height.equalTo((57+49*sections.count).reSized)
        }
        
        delegate?.updateHeight(withCell: self, to: (4+31+57+38+49*sections.count).reSized)
        
        foldBtn.setImage(UIImage.init(systemName: "chevron.up")?.reSetSize(Size: CGSize(width: 20.reSized, height: 14.reSized)).withTintColor(getColor(hexValue: 0x686E83, alpha: 0.8), renderingMode: .alwaysOriginal), for: .normal)
        isFolded = false
    }
    
    private func dismissSelection(){
        
        sectionTable.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.25){
            self.mainLayer.snp.updateConstraints { (make) in
                make.height.equalTo(57.reSized)
            }
        }
        
        delegate?.updateHeight(withCell: self, to: 130.reSized)
        
        foldBtn.setImage(UIImage.init(systemName: "chevron.down")?.reSetSize(Size: CGSize(width: 20.reSized, height: 14.reSized)).withTintColor(getColor(hexValue: 0x686E83, alpha: 0.8), renderingMode: .alwaysOriginal), for: .normal)
        isFolded = true
    }
    
    internal func getTable(){
        let table = UITableView()
        
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.register(MPCustomInputSectionCell.self, forCellReuseIdentifier: "Custom Section")
        let footer = UIView()
        footer.backgroundColor = .clear
        table.tableFooterView = footer
        table.separatorColor = getColor(hexValue: 0x515874, alpha: 0.09)
        
        mainLayer.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.height.equalTo((49*sections.count).reSized)
            make.leading.equalToSuperview()
            make.top.equalTo(hintLabel.snp.bottom).offset(15.reSized)
        }
        
        table.isHidden = true
        
        sectionTable = table
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MPCustomInputSectionCell(with: sections[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex != nil {
            let oCell = tableView.cellForRow(at: IndexPath(row: selectedIndex!, section: 0)) as! MPCustomInputSectionCell
            oCell.changeStatus(to: false)
        }
        let cell = tableView.cellForRow(at: indexPath) as! MPCustomInputSectionCell
        cell.changeStatus(to: true)
        cell.setSelected(false, animated: true)
        
        selectedIndex = indexPath.row
        hintLabel.text = sections[selectedIndex!]
    }
}
