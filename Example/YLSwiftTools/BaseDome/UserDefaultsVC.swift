//
//  UserDefaultsVC.swift
//  YLSwiftTools_Example
//
//  Created by youzimu on 2022/4/13.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import YLSwiftTools

class UserDefaultsVC: YLBaseViewController {

    let showTitleLabel = YLRedudeCode.createUILabel(text: "", textColor: .red, font: UIFont.systemFont(ofSize: 14))
    // MARK: -  数据初始化
    func setupData() {
        
        
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
extension UserDefaultsVC {
    
    func setupUI() {
        self.navTitleLabel.text = "UserDefaults_Dome"
        
        let saveInfoBut = YLRedudeCode.createUIButton(title: "存", titleColor: .white, font: 14.yl_medium, bgColor: .red, image: nil)
        
        
        let readInfoBut = YLRedudeCode.createUIButton(title: "取", titleColor: .white, font: 14.yl_medium, bgColor: .red, image: nil)
        
        view.addSubview(saveInfoBut)
        saveInfoBut.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(customNavView.snp.bottom).offset(100)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        
        view.addSubview(readInfoBut)
        readInfoBut.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(saveInfoBut.snp.bottom).offset(100)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        saveInfoBut.addTarget(self, action: #selector(saveInfoButClicked), for: .touchUpInside)
        readInfoBut.addTarget(self, action: #selector(readInfoButClicked), for: .touchUpInside)
        
        view.addSubview(showTitleLabel)
        showTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(readInfoBut.snp.right).offset(20)
            make.centerY.equalTo(readInfoBut)
            make.right.equalTo(view)
        }
        
    }
    
}

// MARK: - 🎬 ActionMethod
extension UserDefaultsVC {
    
    @objc func saveInfoButClicked() {
        // 存单数据
//        YLDefaults.shared.yl_set("test UserDefaults save", for: Key<String>("TEST_SAVE"))
        
        //存model
        let studentModel1 = TestStudentModel(name: "小明", age: 8)
        let studentModel2 = TestStudentModel(name: "欣欣", age: 9)
        let classModel = TestClassModel.init(className: "一年级", Students: [studentModel1,studentModel2])

        YLDefaults.shared.yl_set(classModel, for: Key<TestClassModel>("TEST_MODEL"))
        
        
    }
    
    @objc func readInfoButClicked() {
//        let tests = YLDefaults.shared.yl_has(Key<String>("TEST_SAVE"))
//        yl_Dlog(tests)
//        showTitleLabel.text = YLDefaults.shared.yl_get(for: .init("TEST_SAVE"))
        
        let classModel = YLDefaults.shared.yl_has(Key<TestClassModel>("TEST_MODEL"))
        yl_Dlog(classModel)
        
        let classModel2 = YLDefaults.shared.yl_get(for: Key<TestClassModel>("TEST_MODEL"))
        yl_Dlog(classModel2?.Students)
        showTitleLabel.text = (classModel2?.className ?? "")
    }
    
}

// MARK: - 🪐 other
extension UserDefaultsVC {
    
    
    
}


struct TestClassModel: Codable {
    let className: String?
    let Students: [TestStudentModel]?
}

struct TestStudentModel: Codable {
    let name: String?
    let age: Int?
}
