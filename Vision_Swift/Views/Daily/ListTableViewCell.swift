//
//  ListTableViewCell.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    var imgView = UIImageView()
    var titleLabel = UILabel()
    var detailLabel = UILabel()
    var rankLabel = UILabel()
    private var coverView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.setupSubviewsProperty()
    }
    
    func setupSubviews() {
        self.contentView.addSubview(self.imgView)
        self.imgView.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self.contentView)
        })
        
        self.contentView.addSubview(self.coverView)
        self.coverView.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self.contentView)
        })
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.right.left.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView.snp.centerY).offset(-20 * kScale)
            make.height.equalTo(20 * kScale)
        })
        
        self.contentView.addSubview(self.detailLabel)
        self.detailLabel.snp.makeConstraints({ (make) in
            make.right.left.equalTo(self.contentView)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10 * kScale)
            make.height.equalTo(15 * kScale)
        })
        
        self.contentView.addSubview(self.rankLabel)
        self.rankLabel.snp.makeConstraints({ (make) in
            make.right.left.equalTo(self.contentView)
            make.top.equalTo(self.detailLabel.snp.bottom).offset(10 * kScale)
            make.height.equalTo(15 * kScale)
        })
    }
    
    func setupSubviewsProperty() {
        self.coverView.backgroundColor = BLUR_COLOR
        self.titleLabel.font = FontWithNameAndSize(name: FZLTC, size: 17)
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.textColor = UIColor.white
        
        self.detailLabel.font = FontWithNameAndSize(name: FZLTX, size: 15)
        self.detailLabel.textAlignment = NSTextAlignment.center
        self.detailLabel.textColor = UIColor.white
        
        self.rankLabel.font = FontWithNameAndSize(name: Lobster, size: 13)
        self.rankLabel.textAlignment = NSTextAlignment.center
        self.rankLabel.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
