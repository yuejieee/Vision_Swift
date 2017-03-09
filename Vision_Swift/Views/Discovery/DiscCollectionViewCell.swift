//
//  DiscCollectionViewCell.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/18.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class DiscCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var imgView = UIImageView()
    private var coverView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.setupSubviews()
        self.setupSubviewsProperty()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        self.contentView.addSubview(self.imgView)
        self.imgView.snp.makeConstraints({ (make) in
            make.right.left.top.bottom.equalTo(self.contentView)
        })
        
        self.contentView.addSubview(self.coverView)
        self.coverView.snp.makeConstraints({ (make) in
            make.right.left.top.bottom.equalTo(self.contentView)
        })
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView.snp.centerY)
        })
    }
    
    func setupSubviewsProperty() {
        self.coverView.backgroundColor = BLUR_COLOR
        
        self.titleLabel.font = FontWithNameAndSize(name: FZLTC, size: 18)
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.textColor = UIColor.white
    }
}
