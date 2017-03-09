//
//  CategoryModel.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/18.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {
    
    var name = String()
    var describe = String()
    var bgPicture = String()
    var id = NSNumber()
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "description" {
            self.describe = value as! String
        }
    }
}
