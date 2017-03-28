//
//  CollectViewController.swift
//  Vision_Swift
//
//  Created by Kingpin on 2017/3/28.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

class CollectViewController: UIViewController,
UITableViewDelegate,
UITableViewDataSource {

    var tableView: UITableView!
    var dataArray = RealmHandle.shareHandle.allData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataArray = RealmHandle.shareHandle.allData()
        self.tableView.reloadData()
    }

    func setupSubviews() {
        self.tableView = UITableView.init(frame: CGRect(), style: UITableViewStyle.plain)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - tableView delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230 * kScale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let descirbeVC = DescribeViewController()
        self.navigationController?.pushViewController(descirbeVC, animated: true)
        let dataModel = self.dataArray[indexPath.row]
        descirbeVC.dataModel.title = dataModel.title
        descirbeVC.dataModel.type = dataModel.type
        descirbeVC.dataModel.category = dataModel.category
        descirbeVC.dataModel.describe = dataModel.describe
        descirbeVC.dataModel.cover["feed"] = dataModel.cover.feed
        descirbeVC.dataModel.cover["blurred"] = dataModel.cover.blurred
        descirbeVC.dataModel.duration = dataModel.duration as NSNumber
        descirbeVC.dataModel.playUrl = dataModel.playUrl
        descirbeVC.indexPath = indexPath
    }
    
    // MARK: - tableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuse = "tableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuse) as? ListTableViewCell
        if cell == nil {
            cell = ListTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reuse)
        }
        let dataModel = self.dataArray[indexPath.row]
        cell?.selectionStyle = UITableViewCellSelectionStyle.gray
        cell?.titleLabel.text = dataModel.title
        let categoryText = String(describing: "#\(dataModel.category) / ")
        let timeText = String(format: "%02x' %02.f\"", Int(Int(dataModel.duration)/60), Float(Int(dataModel.duration) % 60))
        let detailText = categoryText + timeText
        cell?.detailLabel.text = detailText
        if let imgUrl = dataModel.cover["feed"] {
            cell?.imgView.kf.setImage(with: URL.init(string: String(describing: imgUrl)),
                                      placeholder: UIImage.init(named: "selectedPlaceImage"),
                                      options: nil,
                                      progressBlock: nil,
                                      completionHandler: nil)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rowAction = UITableViewRowAction.init(style: UITableViewRowActionStyle.default, title: "取消收藏") { (rowAction, indexPath) in
            let data = self.dataArray[indexPath.row]
            RealmHandle.shareHandle.deleteData(data.title)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            self.dataArray = RealmHandle.shareHandle.allData()
        }
        rowAction.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        return [rowAction]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
