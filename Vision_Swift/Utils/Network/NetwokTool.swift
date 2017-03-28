//
//  NetwokTool.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class NetwokTool: NSObject {
    // MARK: - 首页数据请求
    class func homeRequest(pageNum: Int, completionHandler: @escaping (Array<DataModel>) -> ()) {
        var dataArray = Array<DataModel>()
        let url = HOMEPAGE_URL.appending(String(pageNum))
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let issueList = json["issueList"]
                for (_, dicJson):(String, JSON) in issueList {
                    let itemList = dicJson["itemList"]
                    for (_, dicJson):(String, JSON) in itemList {
                        if dicJson["type"].stringValue == "video"{
                            let dic = dicJson["data"].dictionaryObject
                            let data = DataModel()
                            data.setValuesForKeys(dic!)
                            dataArray.append(data)
                        }
                    }
                }
                SVProgressHUD.dismiss()
                break
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                break
            }
            completionHandler(dataArray)
        }
    }
    
    // MARK: - 详情请求
    class func categoryRequest(completionHandler: @escaping (Array<CategoryModel>) -> ()) {
        var dataArray = Array<CategoryModel>()
        Alamofire.request(CATEGORY_URL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (_, subJson):(String, JSON) in json {
                    let dic = subJson.dictionaryObject
                    let categoryModel = CategoryModel()
                    categoryModel.setValuesForKeys(dic!)
                    dataArray.append(categoryModel)
                }
                SVProgressHUD.dismiss()
                break
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                break
            }
            completionHandler(dataArray)
        }
    }
    
    // MARK: - 类型请求
    class func categoryDetialRequest(cellId: String, sortCategory: Int, completionHandler: @escaping (Array<DataModel>) -> ()) {
        // http://baobab.kaiyanapp.com/api/v3/videos?categoryId=11&num=20&start=0&strategy=date
        var cate = String()
        if sortCategory == 0 {
            cate = "date"
        } else {
            cate = "shareCount"
        }
        let url = String.init(format: "http://baobab.kaiyanapp.com/api/v3/videos?categoryId=%@&num=20&start=0&strategy=%@", cellId, cate)
        var dataArray = Array<DataModel>()
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let itemList = json["itemList"]
                for (_, dicJson):(String, JSON) in itemList {
                    let dic = dicJson["data"].dictionaryObject
                    let data = DataModel()
                    data.setValuesForKeys(dic!)
                    dataArray.append(data)
                }
                SVProgressHUD.dismiss()
                break
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                break
            }
            completionHandler(dataArray)
        }
    }
    
    // MARK: - 排行请求
    class func chartRequest(category: Int, completionHandler: @escaping (Array<DataModel>) -> ()) {
        var url: String!
        var dataArray = Array<DataModel>()
        if category == 0 {
            url = WEEKLY_CHART
        } else if category == 1 {
            url = MONTHLY_CHART
        } else if category == 2 {
            url = ALL_CHART
        }
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let itemList = json["itemList"]
                for (_, dicJson):(String, JSON) in itemList {
                    let dic = dicJson["data"].dictionaryObject
                    let data = DataModel()
                    data.setValuesForKeys(dic!)
                    dataArray.append(data)
                }
                SVProgressHUD.dismiss()
                break
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                break
            }
            completionHandler(dataArray)
        }
    }
}
