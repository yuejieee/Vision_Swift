//
//  CollectModel.swift
//  Vision_Swift
//
//  Created by Kingpin on 2017/3/27.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import RealmSwift

class CollectModel: Object {
    dynamic var type = ""
    dynamic var title = ""
    dynamic var describe = ""
    dynamic var category = ""
    dynamic var cover: CoverModel!
    dynamic var playUrl = ""
    dynamic var duration = 0
}
