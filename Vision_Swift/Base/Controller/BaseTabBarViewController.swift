//
//  BaseTabBarViewController.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/16.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController, BaseTabBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customTabBar = BaseTabBar.init(frame: self.tabBar.bounds);
        //设置代理
        customTabBar.baseDelegate = self
        //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
        self.tabBar.addSubview(customTabBar)
        
        let dayVC = DayHomeViewController()
        self.addChildViewController(viewController: dayVC, title: "Vision")
        customTabBar.addButton(title: "每日精选")
        
        let discVC = DiscHomeViewController()
        self.addChildViewController(viewController: discVC, title: "Vision")
        customTabBar.addButton(title: "发现更多")
        
        let hotVC = HotHomeViewController()
        self.addChildViewController(viewController: hotVC, title: "Vision")
        customTabBar.addButton(title: "热门排行")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //删除系统自动生成的UITabBarButton
        for child: UIView in self.tabBar.subviews {
            if child.isKind(of: UIControl.classForCoder()) {
                child .removeFromSuperview()
            }
        }
    }
    
    func addChildViewController(viewController: UIViewController, title: String) {
        let navigationVC = BaseNavigationViewController.init(rootViewController: viewController)
        viewController.title = title
        self.addChildViewController(navigationVC)
    }

    func selected(tabBar: BaseTabBar, from: Int, to: Int) {
        self.selectedIndex = to;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
