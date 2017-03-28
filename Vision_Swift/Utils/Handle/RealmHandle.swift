//
//  RealmHandle.swift
//  Vision_Swift
//
//  Created by Kingpin on 2017/3/27.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit
import RealmSwift

class RealmHandle {
    static let shareHandle = RealmHandle()
    private init() {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("CollectData.realm")
        Realm.Configuration.defaultConfiguration = config
        print(String.init(describing: config.fileURL))
    }
    
    func filterData(_ title: String) -> CollectModel {
        let realm = try! Realm()
        let predicate = NSPredicate.init(format: "title = %@", title)
        if let collect = realm.objects(CollectModel.self).filter(predicate).first {
            return collect
        } else {
            return CollectModel()
        }
    }
    
    func addData(_ collect: CollectModel) {
        let realm = try! Realm()
        try! realm.write {
            if self.existData(collect.title) {
                realm.add(collect, update: true)
            } else {
                realm.add(collect)
            }
        }
    }
    
    func deleteData(_ title: String) {
        let realm = try! Realm()
        let collect = self.filterData(title)
        try! realm.write {
            realm.delete(collect.cover)
            realm.delete(collect)
        }
    }
    
    func existData(_ title: String) -> Bool {
        let collect = self.filterData(title)
        if collect.title.characters.count != 0 {
            return true
        } else {
            return false
        }
    }
    
    func allData() -> Results<CollectModel> {
        let realm = try! Realm()
        return realm.objects(CollectModel.self)
    }
}
