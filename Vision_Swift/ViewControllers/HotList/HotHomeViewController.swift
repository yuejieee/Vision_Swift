//
//  HotHomeViewController.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/16.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class HotHomeViewController: SwiftBaseScrollViewController {

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageSubviews()
        self.setupPageSubviewsProperty()
    }
    
    func setupPageSubviews() {
        self.arrayTitle = ["周排行", "月排行", "总排行"]
        var index = 0
        for _ in self.arrayTitle {
            let chartVC = ChartsViewController()
            chartVC.category = index
            self.addChildViewController(chartVC)
            index += 1
        }
    }
    
    func setupPageSubviewsProperty() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
