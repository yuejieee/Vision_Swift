//
//  DescribeViewController.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/18.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class DescribeViewController: BaseViewController {
    var dataModel = DataModel()
    var imgView = UIImageView()
    var playBtn = UIButton()
    private var blurView = UIImageView()
    private var coverView = UIView()
    var titleLabel = UILabel()
    var detailLabel = UILabel()
    var describeLabel = UILabel()
    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageSubviews()
        self.setupValue()
        self.setupPageSubviewsProperty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupPageSubviews() {
        self.view.addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left).offset(-150 * kScale)
            make.right.equalTo(self.view.snp.right).offset(150 * kScale)
            make.height.equalTo(400 * kScale)
        }
        self.playBtn = UIButton.init(type: UIButtonType.custom)
        self.imgView.addSubview(self.playBtn)
        self.playBtn.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(60 * kScale)
        }
        self.view.addSubview(self.blurView)
        self.blurView.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgView.snp.bottom)
            make.bottom.left.right.equalTo(self.view)
        }
        self.view.addSubview(self.coverView)
        self.coverView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.blurView)
        }
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.blurView).offset(10 * kScale)
            make.right.equalTo(self.blurView.snp.right).offset(-10 * kScale)
            make.height.equalTo(20 * kScale)
        }
        self.view.addSubview(self.detailLabel)
        self.detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10 * kScale)
            make.left.right.equalTo(self.titleLabel)
            make.height.equalTo(15 * kScale)
        }
        self.view.addSubview(self.describeLabel)
        self.describeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.detailLabel.snp.bottom).offset(10 * kScale)
            make.left.right.equalTo(self.detailLabel)
            make.height.equalTo(100)
        }
    }
    
    func setupPageSubviewsProperty() {
        self.view.clipsToBounds = true
        self.imgView.isUserInteractionEnabled = true
        self.playBtn.addTarget(self, action: #selector(enterPlayer(sender:)), for: UIControlEvents.touchUpInside)
        self.playBtn.backgroundColor = UIColor.lightGray
        self.blurView.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI));
        self.coverView.backgroundColor = BLUR_COLOR
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = FontWithNameAndSize(name: FZLTC, size: 17 * kScale)
        self.detailLabel.textColor = UIColor.white
        self.detailLabel.font = FontWithNameAndSize(name: FZLTX, size: 15 * kScale)
        self.describeLabel.textColor = UIColor.white
        self.describeLabel.font = FontWithNameAndSize(name: FZLTX, size: 15 * kScale)
        self.describeLabel.numberOfLines = 0
        self.describeLabel.sizeToFit()
        //创建NSMutableAttributedString实例，并将text传入
        let attStr = NSMutableAttributedString.init(string: self.describeLabel.text!)
        //创建NSMutableParagraphStyle实例
        let style = NSMutableParagraphStyle()
        //设置行距
        style.lineSpacing = 3 * kScale
        //根据给定长度与style设置attStr式样
        attStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange(location: 0, length: attStr.length))
        //Label获取attStr式样
        self.describeLabel.attributedText = attStr;
    }
    
    func setupValue() {
        if let imgUrl = self.dataModel.cover["feed"] {
            self.imgView.kf.setImage(with: URL.init(string: String(describing: imgUrl)),
                                      placeholder: nil,
                                      options: nil,
                                      progressBlock: nil,
                                      completionHandler: nil)
        }
        if let imgUrl = self.dataModel.cover["blurred"] {
            self.blurView.kf.setImage(with: URL.init(string: String(describing: imgUrl)),
                                      placeholder: nil,
                                      options: nil,
                                      progressBlock: nil,
                                      completionHandler: nil)
        }
        self.titleLabel.text = self.dataModel.title
        let categoryText = String(describing: "#\(dataModel.category) / ")
        let timeText = String(format: "%02x' %02.f\"", Int(Int(dataModel.duration) / 60), Float(Int(dataModel.duration) % 60))
        let detailText = categoryText + timeText
        self.detailLabel.text = detailText
        self.describeLabel.text = self.dataModel.describe
    }
    
    // MARK: - PresentAnimatorDelegate
    func getImage() -> UIImageView {
        return self.imgView
    }
    
    func currentIndexPath() -> IndexPath {
        return self.indexPath
    }
    
    // MARK: - event response
    func enterPlayer(sender: UIButton) {
        let playerVC = PlayerViewController()
        playerVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        playerVC.videoURL = self.dataModel.playUrl
        playerVC.videoTitle = self.dataModel.title
        self.present(playerVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
