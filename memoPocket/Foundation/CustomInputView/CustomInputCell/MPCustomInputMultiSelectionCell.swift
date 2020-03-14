//
//  MPCustomInputMultiSelectionCell.swift
//  memoPocket
//
//  Created by Macsed on 2020/3/10.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomInputMultiSelectionCell : MPCustomInputSingleSelectionCell{
    
    private var selectedIndexs : Set<Int> = []
    private var highLevel : [String]!
    
    convenience init(withTitle title : String,withHint hint : String,withSections sections:[String],withHighLevels highLevels: [String]?){
        self.init()
        self.sections = sections
        self.highLevel = highLevels
        getView(withTitle: title ,withHint: hint, hasFold: true)
        foldBtn.addTarget(self, action: #selector(foldPressed), for: .touchUpInside)
        getTable()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedIndexs.contains(indexPath.row){
            let cell = tableView.cellForRow(at: indexPath) as! MPCustomInputSectionCell
            cell.changeStatus(to: false)
            cell.setSelected(false, animated: true)
            selectedIndexs.remove(indexPath.row)
        }else{
            var hasHighLevel = false
            for index in selectedIndexs{
                let section = sections[index]
                if highLevel.contains(section){
                    hasHighLevel = true
                    break
                }
            }
            
            if !hasHighLevel{
                
                if highLevel.contains(sections[indexPath.row]){
                    
                    if selectedIndexs != []{
                        let nowCell = tableView.cellForRow(at: indexPath) as! MPCustomInputSectionCell
                        nowCell.setSelected(false, animated: true)
                        for index in selectedIndexs{
                            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! MPCustomInputSectionCell
                            cell.setSelected(true, animated: true)
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                                cell.setSelected(false, animated: true)
                            }
                        }
                    }else{
                        let cell = tableView.cellForRow(at: indexPath) as! MPCustomInputSectionCell
                        cell.changeStatus(to: true)
                        cell.setSelected(false, animated: true)
                        selectedIndexs.insert(indexPath.row)
                    }
                    
                }else{
                    let cell = tableView.cellForRow(at: indexPath) as! MPCustomInputSectionCell
                    cell.changeStatus(to: true)
                    cell.setSelected(false, animated: true)
                    selectedIndexs.insert(indexPath.row)
                }
                
            }else{
                let cell = tableView.cellForRow(at: IndexPath(row: selectedIndexs.first!, section: 0)) as! MPCustomInputSectionCell
                cell.setSelected(true, animated: true)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    cell.setSelected(false, animated: true)
                }
                
                let ocell = tableView.cellForRow(at: indexPath) as! MPCustomInputSectionCell
                ocell.setSelected(false, animated: true)
            }
            
        }
        
        var output = ""
        for index in selectedIndexs{
            output = output + sections[index] + ","
        }
        
        if output != ""{
            output.remove(at: output.index(output.startIndex,offsetBy: output.count - 1))
            hintLabel.text = output
        }else{
            hintLabel.text = "请设置"
        }
        
    }
    
}
