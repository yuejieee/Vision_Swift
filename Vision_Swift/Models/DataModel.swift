//
//  DataModel.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    var type = String()
    var title = String()
    var describe = String()
    var category = String()
    var cover = Dictionary<String, Any>()
    var playUrl = String()
    var duration = NSNumber()
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "description" {
            self.describe = value as! String
        }
    }
    
}
