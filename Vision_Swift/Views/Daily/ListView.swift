//
//  ListView.swift
//  Vision_Swift
//
//  Created by Kingpin on 2017/3/27.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

protocol ListViewDelegate {
    func selected(_ index: Int)
}

class ListView: UIView,
UITableViewDelegate,
UITableViewDataSource {
    
    var listDeleagete: ListViewDelegate!
    var tableView: UITableView!
    let array = ["我的收藏", "关于"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: kScreen_Width, height: 0), style: UITableViewStyle.plain)
        self.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - tableView delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * kScale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.listDeleagete.selected(indexPath.row)
        self.hide()
    }

    // MARK: - tableView date source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuse = "tableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuse)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reuse)
        }
        cell?.textLabel?.text = self.array[indexPath.row]
        cell?.textLabel?.textAlignment = NSTextAlignment.center
        return cell!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hide()
    }
    
    // MARK: - private method
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.2) {
            self.tableView.frame = CGRect.init(x: 0, y: 64, width: kScreen_Width, height: 100 * kScale)
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.2, animations: { 
            self.backgroundColor = UIColor.init(white: 0, alpha: 0)
            self.tableView.frame = CGRect.init(x: 0, y: 64, width: kScreen_Width, height: 0)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
