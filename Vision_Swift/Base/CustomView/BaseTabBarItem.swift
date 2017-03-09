//
//  BaseTabBarItem.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/16.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class BaseTabBarItem: UIButton {

    var item: UIBarButtonItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.titleLabel?.font = UIFont.init(name: FZLTX, size: 16)
        self.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        self.setTitleColor(RGB_COLOR(r: 100, g: 100, b: 100, a: 1), for: UIControlState.selected)
        self.item = UIBarButtonItem.init()
        self.item?.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
        self.item?.addObserver(self, forKeyPath: "badgeValue", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.item?.removeObserver(self, forKeyPath: "title")
        self.item?.removeObserver(self, forKeyPath: "badgeValue")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.setTitle(self.item?.title, for: UIControlState.normal)
        self.setTitle(self.item?.title, for: UIControlState.selected)
    }

}
