//
//  Marco.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/16.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
import Kingfisher

let kScreen_Width = UIScreen.main.bounds.width

let kScreen_Height = UIScreen.main.bounds.height

let kScale = kScreen_Width / 375

// 三种自定义字体名
let Lobster = "Lobster1.4"

let FZLTX = "FZLTXIHJW--GB1-0"

let FZLTC = "FZLTZCHJW--GB1-0"

// 颜色
func RGB_COLOR(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor.init(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}

func ARC4RANDOM_COLOR() -> UIColor
{
    return UIColor.init(red: CGFloat(arc4random_uniform(256))/CGFloat(255.0), green: CGFloat(arc4random_uniform(256))/CGFloat(255.0), blue: CGFloat(arc4random_uniform(256))/CGFloat(255.0), alpha: 1)
}

let BACKGROUND_COLOR = RGB_COLOR(r: 235, g: 235, b: 235, a: 1)

let BLUR_COLOR = UIColor.init(white: 0, alpha: 0.4)

// 字体适配
func FontWithSize(size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size * kScale)
}

func FontWithNameAndSize(name: String, size: CGFloat) -> UIFont {
    return UIFont.init(name: name, size: size * kScale)!
}



