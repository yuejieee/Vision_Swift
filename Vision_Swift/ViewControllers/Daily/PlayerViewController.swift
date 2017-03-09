//
//  PlayerViewController.swift
//  Vision_Swift
//
//  Created by yuejieee on 2017/3/6.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController,
MHAVPlayerSDKDelegate {

    var videoURL: String!
    var videoTitle: String!
    var mhPlayer: MHAVPlayerSDK?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.mhPlayer = MHAVPlayerSDK(frame: CGRect())
        self.mhPlayer?.mhPlayerURL = self.videoURL
        self.mhPlayer?.mhPlayerTitle = self.videoTitle
        self.mhPlayer?.mhAutoOrient = true
        self.mhPlayer?.MHAVPlayerSDKDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.mhPlayer!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    deinit {
        self.mhPlayer?.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
