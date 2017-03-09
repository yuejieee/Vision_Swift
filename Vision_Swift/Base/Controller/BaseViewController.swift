//
//  BaseViewController.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/16.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit
import Kingfisher

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BACKGROUND_COLOR
        //标题字体
        let dic = [NSFontAttributeName:UIFont.init(name: Lobster, size: 23) as Any, NSForegroundColorAttributeName:UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = dic as [String: Any]
        self.navigationController?.navigationItem.title = "Vision"
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
