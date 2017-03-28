//
//  GuideViewController.swift
//  Vision_Swift
//
//  Created by Kingpin on 2017/3/10.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit
import AVFoundation

class GuideViewController: UIViewController {
    
    var avPlayerItem: AVPlayerItem?
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var insideBtn: UIButton!
    var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPlayer()
        self.setupSubviews()
        self.setupSubviewsProperty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 3) {
            self.insideBtn.alpha = 0.7
        }
    }
    
    func setupPlayer() {
        let url = Bundle.main.url(forResource: "0", withExtension: "mp4")
        self.avPlayerItem = AVPlayerItem.init(url: url!)
        self.avPlayer = AVPlayer.init(playerItem: avPlayerItem)
        self.avPlayerLayer = AVPlayerLayer.init(player: avPlayer)
        self.avPlayerLayer?.frame = self.view.bounds
        self.view.layer.addSublayer(self.avPlayerLayer!)
        self.avPlayer?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(didPlayEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func setupSubviews() {
        self.insideBtn = UIButton.init(type: UIButtonType.system)
        self.view.addSubview(self.insideBtn)
        self.insideBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(100 * kScale)
            make.right.bottom.equalTo(self.view).offset(-100 * kScale)
            make.height.equalTo(40 * kScale)
        }
        
        self.titleLabel = UILabel()
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(100 * kScale)
            make.height.equalTo(50 * kScale)
        }
    }
    
    func setupSubviewsProperty() {
        self.insideBtn.setTitle("进入视野", for: UIControlState.normal)
        self.insideBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.insideBtn.titleLabel?.font = FontWithNameAndSize(name: FZLTC, size: 17)
        self.insideBtn.backgroundColor = UIColor.black
        self.insideBtn.alpha = 0
        self.insideBtn.layer.cornerRadius = 5 * kScale
        self.insideBtn.addTarget(self, action: #selector(insideAction(sender:)), for: UIControlEvents.touchUpInside)
        
        self.titleLabel.text = "Vision"
        self.titleLabel.font = FontWithNameAndSize(name: Lobster, size: 55)
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.textAlignment = NSTextAlignment.center
    }
    
    func didPlayEnd(notification: NotificationCenter) {
        self.avPlayerItem?.seek(to: kCMTimeZero)
        self.avPlayer?.play()
    }
    
    // MARK: - event response
    func insideAction(sender: UIButton) {
        UIApplication.shared.keyWindow?.rootViewController = BaseTabBarViewController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
