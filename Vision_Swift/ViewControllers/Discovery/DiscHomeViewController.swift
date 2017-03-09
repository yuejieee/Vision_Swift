//
//  DiscHomeViewController.swift
//  Vision_Swift
//
//  Created by 岳杰 on 2017/1/16.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit
import SVProgressHUD

class DiscHomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView?
    var flowLayout: UICollectionViewFlowLayout?
    var dataArray: Array<CategoryModel>?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageSubviews()
        self.setupSubviewsProperty()
        self.loadData()
    }
    
    func setupPageSubviews() {
        self.flowLayout = UICollectionViewFlowLayout.init()
        self.collectionView = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: flowLayout!)
        self.view.addSubview(self.collectionView!)
        self.collectionView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self.view)
        })
    }
    
    func setupSubviewsProperty() {
        self.flowLayout?.itemSize = CGSize.init(width: (kScreen_Width - 5) / 2, height: (kScreen_Width - 5) / 2)
        self.flowLayout?.minimumLineSpacing = 5;
        self.flowLayout?.minimumInteritemSpacing = 0;
        self.collectionView?.backgroundColor = BACKGROUND_COLOR
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(DiscCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "collectionView")
    }
    
    // MARK: - 数据请求
    func loadData() {
        SVProgressHUD.show()
        NetwokTool.categoryRequest { (array) in
            self.dataArray = array
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: - UICollectionViewDelegate and UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let num = self.dataArray?.count {
            return num
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as!DiscCollectionViewCell
        if let categoryModel = self.dataArray?[indexPath.item] {
            cell.titleLabel.text = String("#\(categoryModel.name)")
            let imgUrl = categoryModel.bgPicture
            cell.imgView.kf.setImage(with: URL.init(string: imgUrl),
                                     placeholder: UIImage.init(named: "discPlaceHolder"),
                                     options: nil, progressBlock: nil,
                                     completionHandler: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let discVC = DiscDetailViewController()
        if let model = self.dataArray?[indexPath.item] {
            discVC.cellId = String(describing: model.id)
            self.navigationController?.pushViewController(discVC, animated: true)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
