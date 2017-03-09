//
//  DiscDetailViewController.swift
//  Vision_Swift
//
//  Created by Kingpin on 2017/3/8.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class DiscDetailViewController: SwiftBaseScrollViewController {

    var cellId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrayTitle = ["按时间排行", "按分享排行"]
        var index = 0
        for _ in self.arrayTitle {
            let discVC = DiscListViewController()
            discVC.cellId = self.cellId
            discVC.sortCategory = index
            self.addChildViewController(discVC)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "tabBarHiden"), object: self)
            index += 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
