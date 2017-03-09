//
//  BaseTabBar.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/16.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

protocol BaseTabBarDelegate {
    func selected(tabBar: BaseTabBar, from: Int, to: Int)
}

class BaseTabBar: UITabBar {
    
    var baseDelegate: BaseTabBarDelegate?
    
    var selectedBtn = BaseTabBarItem()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let count: NSInteger = self.subviews.count;
        for i in 1 ..< count {
            //取得按钮
            let btn = self.subviews[i] as! BaseTabBarItem;
            btn.tag = i - 1; //设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
            
            let x: CGFloat = CGFloat(i - 1) * CGFloat(self.bounds.size.width) / CGFloat(count - 1)
            let y: CGFloat = 0
            let width: CGFloat = CGFloat(self.bounds.size.width) / CGFloat(count - 1)
            let height: CGFloat = self.bounds.size.height;
            btn.frame = CGRect.init(x: x, y: y, width: width, height: height)
            
            if btn.tag == 0 {
                btn.isSelected = true
                self.selectedBtn = btn
            }
        }
    }
    
    func addButton(title: String) {
        let baseItem = BaseTabBarItem()
        baseItem.item?.title = title
        baseItem.addTarget(self, action: #selector(click(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(baseItem)
    }
    
    func click(button: BaseTabBarItem) {
        self.baseDelegate?.selected(tabBar: self, from: self.selectedBtn.tag, to: button.tag)
        //1.先将之前选中的按钮设置为未选中
        self.selectedBtn.isSelected = false
        button.isSelected = true
        //3.最后把当前按钮赋值为之前选中的按钮
        self.selectedBtn = button
    }
    

}
