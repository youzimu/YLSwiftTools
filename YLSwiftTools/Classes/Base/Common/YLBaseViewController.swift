//
//  YLBaseViewController.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/1.
//

import UIKit
import MJRefresh
open class YLBaseViewController: UIViewController {
    
    public lazy var leftBackBut: UIButton = {
        let but = UIButton.init(type: .custom)
        but.setImage(YLCommom.yl_GetXcassetsImage("YLSwiftTools", "backArrow"), for: .normal)
        but.setImage(YLCommom.yl_GetXcassetsImage("YLSwiftTools", "backArrow"), for: .selected)
        but.addTarget(self, action: #selector(leftBackClicked), for: .touchUpInside)
        return but
    }()
    public lazy var rightBut: UIButton = {
        let but = UIButton.init(type: .custom)
        but.addTarget(self, action: #selector(rightClicked), for: .touchUpInside)
        return but
    }()
    public lazy var navTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = 18.yl_medium
        label.textColor = UIColor(red: 0.21, green: 0.22, blue: 0.23, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    public lazy var titleView: UIView = {
        let view = UIView()
        view.addSubview(navTitleLabel)
        navTitleLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 200, height: yl_NavHight)
        return view
    }()
    
    public lazy var navBackImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isHidden = true
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    public lazy var customNavView: UIView = {
        let navView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: yl_StatusBarHeight + yl_NavHight))
        navView.backgroundColor = .clear
        
        navView.addSubview(navBackImageView)
        navBackImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: yl_StatusBarHeight + yl_NavHight)
        
        navView.addSubview(titleView)
        titleView.frame = CGRect(x: 100, y: yl_StatusBarHeight, width: navView.frame.size.width - 200, height: yl_NavHight)
        
        navView.addSubview(leftBackBut)
        leftBackBut.frame = CGRect(x: 0, y: yl_StatusBarHeight, width: 50, height: yl_NavHight)
        

        return navView
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MARK: - 隐藏滑动返回时，原生返回按钮显示问题
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        
        view.backgroundColor = .white

        view.addSubview(customNavView)
    }

    // MARK: - 隐藏导航栏
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        // MARK: - 首界面隐藏返回按钮
        if let count = self.navigationController?.viewControllers.count, count == 1 {
            leftBackBut.isHidden = true
            
        }
    }
    // MARK: - 显示导航栏
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: -  🔨 CustomMethod
public extension YLBaseViewController {
    
    // MARK: - 设置右边文字按钮
    func setRightTitleBut(_ butTitle: String, titleColor: UIColor, titFont: CGFloat = 16, butWidth: CGFloat = 64) {
        customNavView.addSubview(rightBut)
        rightBut.frame = CGRect(x: customNavView.frame.size.width - butWidth, y: yl_StatusBarHeight, width: butWidth, height: yl_NavHight)
        rightBut.setTitle(butTitle, for: .normal)
        rightBut.setTitleColor(titleColor, for: .normal)
        rightBut.titleLabel?.font = UIFont.systemFont(ofSize: titFont)
    }
    // MARK: - 设置右边图片按钮
    func setRightImageBut(_ bgImageName: String, butWidth: CGFloat = 64) {
        customNavView.addSubview(rightBut)
        rightBut.frame = CGRect(x: customNavView.frame.size.width - butWidth, y: yl_StatusBarHeight, width: butWidth, height: yl_NavHight)
        rightBut.setImage(UIImage.init(named: bgImageName), for: .normal)
        rightBut.setImage(UIImage.init(named: bgImageName), for: .selected)
    }
    // MARK: - 设置左边文字按钮
    func setCustomLeftTitleBut(_ butTitle: String, titleColor: UIColor, titFont: CGFloat = 16, butWidth: CGFloat = 64) {
        let leftBut = UIButton.init(type: .custom)
        leftBackBut.removeFromSuperview()
        customNavView.addSubview(leftBut)
        leftBut.frame = CGRect(x: 0, y: yl_StatusBarHeight, width: butWidth, height: yl_NavHight)
        leftBut.setTitle(butTitle, for: .normal)
        leftBut.setTitleColor(titleColor, for: .normal)
        leftBut.titleLabel?.font = UIFont.systemFont(ofSize: titFont)
        leftBut.addTarget(self, action: #selector(customLeftClicked), for: .touchUpInside)
    }
    // MARK: - 设置导航栏背景图片
    func setNavBackImageName(_ imgName: String) {
        navBackImageView.isHidden = false
        navBackImageView.image = UIImage.init(named: imgName)
        navTitleLabel.textColor = .white
    }
    // MARK: - 设置tableView默认值
    func configTableView(_ tableView: UITableView, refreshable: Bool = false) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag  //键盘会当tableView上下滚动的时候自动收起
        // MARK: - plain类型的UITableView增加默认的section高度
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        if (refreshable) {
            tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefreshAction(_ :)))
            
            tableView.mj_footer = MJRefreshBackFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshAction(_ :)))
        }
    }
    
    func endRefreshTableView(_ tableView: UITableView) {
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
        tableView.mj_footer?.endRefreshing()
    }
    
    func noticeNoMoreData(_ tableView: UITableView) {
        tableView.mj_footer?.endRefreshingWithNoMoreData()
    }
    
    
}


// MARK: - 🎬 ActionMethod
 extension YLBaseViewController {
    
    @objc open func leftBackClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc open func rightClicked() {
        
    }
    
     @objc open func customLeftClicked() {
        
    }
    
    @objc open func headerRefreshAction(_ mj_header: MJRefreshHeader?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if mj_header?.isKind(of: MJRefreshHeader.self) ?? false {
                mj_header?.endRefreshing()
            }
        }
    }
    
    @objc open func footerRefreshAction(_ mj_footer: MJRefreshFooter?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if mj_footer?.isKind(of: MJRefreshFooter.self) ?? false {
                mj_footer?.endRefreshing()
            }
        }
    }
}

// MARK: - ⛓ DelegateMethod
extension YLBaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}
