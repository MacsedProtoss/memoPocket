//
//  MPCustomInputTableController.swift
//  memoPocket
//
//  Created by Macsed on 2020/3/10.
//  Copyright © 2020 Macsed. All rights reserved.
//

import UIKit
import SnapKit

class MPCustomInputTableController : UIViewController,UITableViewDelegate,UITableViewDataSource,MPCustomInputCellDelegate{
    
    internal var table : UITableView!
    private var cells : [MPCustomInputBaseCell] = []
    private var heights : Dictionary<MPCustomInputBaseCell,CGFloat> = [:]
    private var firstLoad = true
    private var cellInfos : [MPCustomInputCellInfo] = []
    
    convenience init(cellInfos : [MPCustomInputCellInfo]){
        self.init()
        self.cellInfos = cellInfos
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstLoad = false
    }
    
    internal func getView(){
        view.backgroundColor = .clear
        table = {
            let t = UITableView()
            t.backgroundColor = .clear
            t.register(MPCustomInputBaseCell.self, forCellReuseIdentifier: "Custom Input")
            t.dataSource = self
            t.delegate = self
            view.addSubview(t)
            t.snp.makeConstraints { (make) in
                make.leading.trailing.top.bottom.equalToSuperview()
            }
            
            let footer = UIView()
            footer.backgroundColor = .clear
            t.tableFooterView = footer
            t.separatorStyle = .none
            
            t.allowsSelection = false
            return t
        }()
    }
    
    func updateHeight(withCell cell: MPCustomInputBaseCell, to height: CGFloat) {
        heights[cell] = height
        let offset = table.contentOffset
        table.beginUpdates()
        table.endUpdates()
        table.setContentOffset(offset, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if firstLoad{
            let info = cellInfos[indexPath.row]
            switch info.type {
            case is MPCustomInputPureTextCell.Type:
                let cell = MPCustomInputPureTextCell(withTitle: info.title, withHint: info.hint)
                cell.delegate = self
                cells.append(cell)
                return cell
            case is MPCustomInputMultiSelectionCell.Type:
                let cell = MPCustomInputMultiSelectionCell(withTitle: info.title, withHint: info.hint, withSections: info.setctions!,withHighLevels: info.highLevelSections!)
                cell.delegate = self
                cells.append(cell)
                return cell
            case is MPCustomInputSingleSelectionCell.Type:
                let cell = MPCustomInputSingleSelectionCell(withTitle: info.title, withHint: info.hint, withSections: info.setctions!)
                cell.delegate = self
                cells.append(cell)
                return cell
            case is MPCustomInputDatePickCell.Type:
                let cell = MPCustomInputDatePickCell(withTitle: info.title, withHint: info.hint)
                cell.delegate = self
                cells.append(cell)
                return cell
            default:
                fatalError("this type of Cell is not defiened")
            }
        }else{
            return cells[indexPath.row]
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !firstLoad{
            if let height = heights[cells[indexPath.row]]{
                return height
            }else{
                fatalError("can't get cell's height")
            }
        }else{
            heights[cells[indexPath.row]] = 130.reSized
            return 130.reSized
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.setSelected(false, animated: false)
    }
    
}
