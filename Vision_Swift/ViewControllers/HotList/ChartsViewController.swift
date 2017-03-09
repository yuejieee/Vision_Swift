//
//  ChartsViewController.swift
//  Vision_Swift
//
//  Created by Kingpin on 2017/3/8.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChartsViewController: BaseViewController,
UITableViewDelegate,
UITableViewDataSource,
UIViewControllerPreviewingDelegate {
    
    var tabelView = UITableView()
    var dataArray = Array<DataModel>()
    var category: Int! {
        didSet {
            self.loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageSubviews()
        self.setupPageSubviewsProperty()
        self.loadData()
    }
    
    func setupPageSubviews() {
        self.view.addSubview(self.tabelView)
        self.tabelView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func setupPageSubviewsProperty() {
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.tabelView.tableFooterView = UIView()
        self.tabelView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    func loadData() {
        SVProgressHUD.show()
        NetwokTool.chartRequest(category: self.category) { (array) in
            self.dataArray = array
            self.tabelView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK: - tableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230 * kScale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let describeVC = DescribeViewController()
        describeVC.dataModel = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(describeVC, animated: true)
    }
    
    // MARK: - tableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "tableView") as? ListTableViewCell
        if cell == nil {
            cell = ListTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "tableView")
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
        // 判断是否支持3DTouch
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            self.registerForPreviewing(with: self, sourceView: cell!)
        }
        return cell!
    }
    
    // MARK: - UIViewControllerPreviewingDelegate
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let indexPath = self.tabelView.indexPath(for: previewingContext.sourceView as! ListTableViewCell)
        let descirbeVC = DescribeViewController()
        let dataModel = self.dataArray[(indexPath?.row)!]
        descirbeVC.dataModel = dataModel
        descirbeVC.indexPath = indexPath!
        return descirbeVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.show(viewControllerToCommit, sender: self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
