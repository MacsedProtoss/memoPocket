//
//  NewViewController.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import UIKit
import SnapKit
import UserNotifications

class NewViewController: UITableViewController {

//    let closeHeight: CGFloat = 0
//    let openHeight: CGFloat = 55
//    var itemCount = [2, 1, 1, 5]
//
//    // 对象
//    private var targetSource = ["请选择发送对象", "爸爸", "妈妈"]
//    private var targetHeight = [CGFloat](repeating: 0, count: 3)
//
//    // 时间
//    private var timeHeight: [CGFloat] = [55, 0]
//    private var timeSource = ["请选择时间", "Time"]
//
//    // 重复
//    private var repeatSource = ["请设置是否重复", "永不", "每天", "每周一", "每周二", "每周三", "每周四", "每周五", "每周六", "每周日"]
//    private var repeatHeight = [CGFloat](repeating: 0, count: 10)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        initView()
//        registerCells()
//    }
//
//    private func initView() {
//        // self
//        self.view.backgroundColor = UIColor(named: "grey-1")
//        self.tabBarController?.tabBar.isHidden = true
//        // NavigationBar
//        let navigationBar = self.navigationController!.navigationBar
//        navigationBar.titleTextAttributes =
//                [NSAttributedString.Key.foregroundColor: UIColor(named: "text")!,
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
//        let backImage = UIImage(named: "back")?.reSetSize(Size: CGSize(width: 13, height: 24))
//        let backButtonItem = UIBarButtonItem(image: backImage, style: .plain, target:
//            nil, action: #selector(backButtonPressed))
//        let negativeLefPadding = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target:
//        nil, action: nil)
//        negativeLefPadding.width = -10
//        self.navigationItem.setLeftBarButtonItems([negativeLefPadding, backButtonItem], animated: true)
//        navigationBar.backIndicatorImage = backImage
//        navigationBar.backIndicatorTransitionMaskImage = backImage
//        navigationBar.tintColor = UIColor(named: "text")
//        navigationBar.topItem?.title = ""
//
//        self.navigationItem.title = "新建提醒"
//
//        // TableView
//        self.tableView.backgroundColor = UIColor(named: "grey-1")
//        self.tableView.separatorStyle = .singleLine
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//        self.tableView.tableFooterView = UIView()
//        self.tableView.tableHeaderView?.backgroundColor = .none
//        self.tableView.tableFooterView?.backgroundColor = .none
//
//
//        targetHeight[0] = 55
//        repeatHeight[0] = 55
//    }
//
//}
//
//extension NewViewController {
//
//    private func registerCells() {
//        tableView.register(RoundCell.self, forCellReuseIdentifier: "Cell")
//        tableView.register(TimeCell.self, forCellReuseIdentifier: "TimeCell")
//        tableView.register(ButtonCell.self, forCellReuseIdentifier: "ButtonCell")
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return targetSource.count
//        case 2:
//            return 2
//        case 3:
//            return repeatSource.count
//        default:
//            return 1
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 0:
//            return targetHeight[indexPath.row]
//        case 2:
//            return timeHeight[indexPath.row]
//        case 3:
//            return repeatHeight[indexPath.row]
//        default:
//            return 55
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = UITableViewCell()
//        switch indexPath.section {
//        case 0:
//            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RoundCell
//            cell.textLabel?.text = targetSource[indexPath.row]
//        case 1:
//            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//            let textField = UITextField()
//            textField.placeholder = "输入内容在15字以内"
//            textField.textColor = UIColor(named: "text")
//            cell.addSubview(textField)
//            textField.snp.makeConstraints { (make) in
//                make.size.equalToSuperview()
//                make.left.right.equalTo(20)
//            }
//        case 2:
//            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//            if indexPath.row == 0 {
//                cell.textLabel?.text = timeSource[indexPath.row]
//            } else {
//                let datePicker = UIDatePicker()
//                datePicker.locale = Locale.init(identifier: "zh-Hans")
//                datePicker.datePickerMode = .dateAndTime
//                cell.addSubview(datePicker)
//                datePicker.snp.makeConstraints { (make) in
//                    make.size.equalToSuperview()
//                }
//                datePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
//            }
//        case 3:
//            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//            cell.textLabel?.text = repeatSource[indexPath.row]
//        case 4:
//            cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath)
//            cell.backgroundColor = UIColor(named: "purple")
//            cell.textLabel?.text = "确 认"
//        default:
//            cell.textLabel?.text = "第\(indexPath.row)个cell"
//        }
//        if let cell = cell as? RoundCell {
//            if indexPath.row == 0 {
//                cell.top = true
//                cell.bottom = true
//            } else if indexPath.row == 1 && tableView.numberOfRows(inSection: indexPath.section) > 1 {
//                cell.top = true
//                cell.bottom = false
//            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//                cell.top = false
//                cell.bottom = true
//            } else {
//                cell.top = false
//                cell.bottom = false
//            }
//        }
//        cell.clipsToBounds = true
//        cell.selectionStyle = .none
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var duration = 0.3
//        let cell = tableView.cellForRow(at: indexPath) as! RoundCell
//        switch indexPath.section {
//        case 0:
//            selectTarget(didSelectRowAt: indexPath)
//        case 2:
//            selectTime(didSelectRowAt: indexPath)
//        case 3:
//            selectRepeat(didSelectRowAt: indexPath)
//            duration = 0.18
//        case 4:
//            selectOK()
//        default:
//            print("click")
//        }
//
//        print(cell.top)
//        print(cell.bottom)
//        UIView.animate(withDuration: duration) {
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
//    }
//
//    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        let label = UILabel()
//        headerView.addSubview(label)
//        switch section {
//        case 0:
//            label.text = "对象："
//        case 1:
//            label.text = "内容："
//        case 2:
//            label.text = "时间："
//        case 3:
//            label.text = "重复："
//        default:
//            label.text = " "
//        }
//        label.snp.makeConstraints { make in
//            make.left.equalTo(39)
//            make.top.equalTo(24)
//        }
//        label.textColor = UIColor(named: "text")
//        // TODO: 修改字体大小
//        return headerView
//    }
//
//    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 52
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 5
//    }
//
//    // 选择对象
//    private func selectTarget(didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            if targetHeight[1] == closeHeight {
//                // 关闭时点击了第一行
//                for i in 1..<targetHeight.count {
//                    targetHeight[i] = openHeight
//                }
//            } else {
//                // 打开时点击了第一行
//                for i in 1..<targetHeight.count {
//                    targetHeight[i] = closeHeight
//                }
//            }
//        } else {
//            // 选择
//            targetSource[0] = targetSource[indexPath.row]
//            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//            for i in 1..<targetHeight.count {
//                targetHeight[i] = closeHeight
//            }
//        }
//    }
//
//    // 选择时间
//    private func selectTime(didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! RoundCell
//        if indexPath.row == 0 {
//            if timeHeight[1] == closeHeight {
//                // 打开时间选择器
//                timeHeight[1] = 200
//                cell.bottom = false
//            } else {
//                // 关闭时间选择器
//                cell.bottom = true
//                timeHeight[1] = closeHeight
//            }
//        }
//    }
//
//    // 选择时间回调
//    @objc private func timeChanged(_ sender: UIDatePicker) {
//        let date = sender.date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm"
//        timeSource[0] = dateFormatter.string(from: date)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
//    }
//
//    // 选择是否重复
//    private func selectRepeat(didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            if repeatHeight[1] == closeHeight {
//                // 关闭时点击了第一行
//                for i in 1..<repeatHeight.count {
//                    repeatHeight[i] = openHeight
//                }
//            } else {
//                // 打开时点击了第一行
//                for i in 1..<repeatHeight.count {
//                    repeatHeight[i] = closeHeight
//                }
//            }
//        } else {
//            // 选择
//            repeatSource[0] = repeatSource[indexPath.row]
//            tableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
//            for i in 1..<repeatHeight.count {
//                repeatHeight[i] = closeHeight
//            }
//        }
//    }
//
//    // 确定
//    private func selectOK() {
//        sendNotification()
//        let vc = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-2] as! RemindVC
//        vc.titles.insert("new", at: 0)
//        for i in (vc.remindview?.visibleCells)!{
//            i.backgroundColor = UIColor(red: 237, green: 239, blue: 244, alpha: 1)
//        }
//        vc.remindview?.reloadData()
//        self.tabBarController?.tabBar.isHidden = false
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    @objc private func backButtonPressed() {
//        print("aaa")
//        self.tabBarController?.tabBar.isHidden = false
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    // 发送通知
//    private func sendNotification() {
//        let center = UNUserNotificationCenter.current()
//        let content = UNMutableNotificationContent()
//        content.title = "记得吃维生素片"
//        content.subtitle = "每天10:00"
//        content.body = "来自：乖乖"
//        content.sound = UNNotificationSound.default
//        content.threadIdentifier = "local-notification"
//
//        let date = Date(timeIntervalSinceNow: 1)
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
//
//        center.add(request) { (error) in
//            if error != nil {
//                print(error)
//            }
//        }
//
//    }

}

