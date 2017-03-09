//
//  DayHomeViewController.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/16.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit
import SVProgressHUD
import DGElasticPullToRefresh

class DayHomeViewController: BaseViewController,
UITableViewDelegate,
UITableViewDataSource,
UIViewControllerPreviewingDelegate {
    
    var tableView: UITableView?
    var dataArray: Array<DataModel>?
    private let loadingView = DGElasticPullToRefreshLoadingViewCircle()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageSubviews()
        self.setupPageSubViewsProperty()
        self.loadData(showProgress: true)
    }
    
    deinit {
        self.tableView?.dg_removePullToRefresh()
    }
    
    func setupPageSubviews() {
        self.tableView = UITableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        self.view.addSubview(self.tableView!)
        self.tableView!.snp.makeConstraints { (make) in
           make.left.right.top.bottom.equalTo(self.view)
        }
        self.tableView?.dg_addPullToRefreshWithActionHandler({ 
            self.loadData(showProgress: false)
        }, loadingView: self.loadingView)
    }
    
    func setupPageSubViewsProperty() {
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView?.backgroundColor = BACKGROUND_COLOR
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.dg_setPullToRefreshFillColor(BACKGROUND_COLOR)
        self.tableView?.dg_setPullToRefreshBackgroundColor(UIColor.white)
        self.loadingView.tintColor = UIColor.lightGray
    }
    
    // MARK: - loadData
    func loadData(showProgress: Bool) {
        if showProgress {
            SVProgressHUD.show()
        }
        NetwokTool.homeRequest { (array) in
            self.dataArray = array
            self.tableView?.reloadData()
            self.tableView?.dg_stopLoading()
        }
    }
    
    // MARK: - UITableViewDelegate and UItableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let num = self.dataArray?.count {
            return num
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230 * kScale
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "tableView") as? ListTableViewCell
        if cell == nil {
            cell = ListTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "tableView")
        }
        if let dataModel = self.dataArray?[indexPath.row] {
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
        }
        // 判断是否支持3DTouch
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            self.registerForPreviewing(with: self, sourceView: cell!)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: false)
        let descirbeVC = DescribeViewController()
        self.navigationController?.pushViewController(descirbeVC, animated: true)
        if let dataModel = self.dataArray?[indexPath.row] {
            descirbeVC.dataModel = dataModel
        }
        descirbeVC.indexPath = indexPath
    }
    
    // MARK: - UIViewControllerPreviewingDelegate
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        var indexPath = self.tableView?.indexPath(for: previewingContext.sourceView as! ListTableViewCell)
        let descirbeVC = DescribeViewController()
        if let dataModel = self.dataArray?[(indexPath?.row)!] {
            descirbeVC.dataModel = dataModel
        }
        descirbeVC.indexPath = indexPath!
        return descirbeVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.show(viewControllerToCommit, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
