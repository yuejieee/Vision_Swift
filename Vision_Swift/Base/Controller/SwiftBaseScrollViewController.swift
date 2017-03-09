//
//  SwiftBaseScrollViewController.swift
//  HappyOneHundred
//
//  Created by 岳杰 on 2017/2/24.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class SwiftBaseScrollViewController: UIViewController,
UIScrollViewDelegate {
    
    var scrollViewTitle = UIScrollView()
    var scrollViewContent = UIScrollView()
    var lineView = UIView()
    var arrayTitle = Array<String>() {
        didSet {
            self.setupTitleAndContent(array: arrayTitle)
        }
    }
    private let btnH = 40 * kScale
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.setupSubviewsProperty()
        self.setupNotification()
    }
    
    func setupSubviews() {
        //标题字体
        let dic = [NSFontAttributeName:UIFont.init(name: Lobster, size: 23) as Any, NSForegroundColorAttributeName:UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = dic as [String: Any]
        self.navigationController?.navigationItem.title = "Vision"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.scrollViewTitle)
        self.scrollViewTitle.frame = CGRect.init(x: 0, y: 64, width: kScreen_Width, height: btnH);
        
        self.view.addSubview(self.scrollViewContent)
        self.scrollViewContent.frame =  CGRect.init(x: 0, y: 64 + btnH, width: kScreen_Width, height: kScreen_Height - btnH - 64 - 49);
        self.scrollViewTitle.addSubview(self.lineView)
    }
    
    func setupTitleAndContent(array: Array<String>) {
        let btnW = kScreen_Width / CGFloat(arrayTitle.count)
        if array.count != 0 {
            var index = 0
            for string in array {
                let button = UIButton.init(type: UIButtonType.custom)
                self.scrollViewTitle.addSubview(button)
                let btnX = btnW * CGFloat(index)
                button.frame = CGRect.init(x: btnX, y: 0, width: btnW, height: btnH)
                button.setTitle(string, for: UIControlState.normal)
                button.setTitleColor(UIColor.black, for: UIControlState.normal)
                button.titleLabel?.font = FontWithSize(size: 15)
                button.tag = index + 1000
                index+=1
                button.addTarget(self, action: #selector(selected(sender:)), for: UIControlEvents.touchUpInside)
            }
            self.scrollViewContent.contentSize = CGSize.init(width: CGFloat(index) * kScreen_Width, height: 0)
            self.lineView.frame = CGRect.init(x: 0, y: btnH - 2, width: btnW, height: 2)
        }
    }
    
    override func addChildViewController(_ childController: UIViewController) {
        super.addChildViewController(childController)
        self.scrollViewContent.addSubview((self.childViewControllers.last?.view)!)
        let index = self.scrollViewContent.subviews.count - 1
        self.scrollViewContent.subviews[index].frame = CGRect.init(x: CGFloat(index) * kScreen_Width, y: 0, width: kScreen_Width, height: kScreen_Height - btnH - 64 - 49)
    }
    
    func setupSubviewsProperty() {
        self.scrollViewTitle.backgroundColor = UIColor.white
        self.scrollViewContent.delegate = self
        self.scrollViewContent.isPagingEnabled = true
        self.scrollViewContent.showsHorizontalScrollIndicator = false
        self.lineView.backgroundColor = UIColor.black
    }
    
    func setupNotification() {
        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "tabBarHiden"), object: self, queue: OperationQueue.main) { (userInfo) in
            let index = self.scrollViewContent.subviews.count - 1
            self.scrollViewContent.subviews[index].frame = CGRect.init(x: CGFloat(index) * kScreen_Width, y: 0, width: kScreen_Width, height: kScreen_Height - self.btnH - 64)
            self.scrollViewContent.frame =  CGRect.init(x: 0, y: 64 + self.btnH, width: kScreen_Width, height: kScreen_Height - self.btnH - 64);
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let btnW = kScreen_Width / CGFloat(arrayTitle.count)
        if scrollView == self.scrollViewContent {
            let offsetX = scrollView.contentOffset.x;
            self.lineView.frame = CGRect.init(x: offsetX/kScreen_Width * btnW, y: btnH - 2, width: btnW, height: 2);
        }
    }
    
    // MARK: - event response
    func selected(sender: UIButton) {
        let index = sender.tag - 1000
        self.scrollViewContent.setContentOffset(CGPoint.init(x: CGFloat(index) * kScreen_Width, y: 0), animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
