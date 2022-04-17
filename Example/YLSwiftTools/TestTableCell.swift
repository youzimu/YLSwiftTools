//
//  TestTableCell.swift
//  YLSwiftTools_Example
//
//  Created by youzimu on 2022/4/13.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import YLSwiftTools

class TestTableCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = YLRedudeCode.createUILabel(text: "", textColor: UIColor.darkText, font: 14.yl_medium)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        yl_Dlog("检测是否有循环引用")
    }
    
    func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
}
