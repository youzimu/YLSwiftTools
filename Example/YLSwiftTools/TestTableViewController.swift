//
//  TestTableViewController.swift
//  YLSwiftTools_Example
//
//  Created by youzimu on 2022/4/11.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import YLSwiftTools
class TestTableViewController: YLBaseViewController {

    lazy var mainTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: customNavView.frame.maxY, width: yl_ScreenWidth, height: yl_ScreenHeight - customNavView.frame.size.height), style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .lightGray
        tableView.rowHeight = 100
        tableView.register(TestTableCell.self, forCellReuseIdentifier: "TestTableCell")
        return tableView
    }()
    var dataArray = [String]()
    // MARK: -  数据初始化
    func setupData() {
        
        dataArray.append("UserDefaults_Dome")
        dataArray.append("Extensions_Dome")
    }
    
    // MARK: - ♻️ Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        
        
    }
    
    deinit {
        yl_Dlog("检测是否有循环引用")
    }
    
}

// MARK: -  🔨 CustomMethod
extension TestTableViewController {
    
    func setupUI() {
        self.navTitleLabel.text = "Dome"
        
        view.addSubview(mainTableView)
        configTableView(mainTableView)
        

    }
    
}

// MARK: - 🎬 ActionMethod
extension TestTableViewController {
    
    
    
}

// MARK: - ⛓ DelegateMethod
extension TestTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableCell", for: indexPath) as! TestTableCell
        cell.title = dataArray[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = UserDefaultsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.section == 1 {
            let vc = DateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - 🌏 NetworkMethod
extension TestTableViewController {
    
    
}

// MARK: - 💤 LazyLoad
extension TestTableViewController {
    
    
    
}

// MARK: - 🪐 other
extension TestTableViewController {
    func getArrayFromJSONString(jsonString:String) ->NSArray{
            
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! NSArray
        }
        return array as! NSArray
        
    }
}

