//
//  DXHomeViewController.swift
//  DXDoctor
//
//  Created by Jone on 15/12/5.
//  Copyright © 2015年 Jone. All rights reserved.
//

import UIKit

class DXHomeViewController: DXBaseViewController {
    fileprivate let topics = ["推荐", "专题", "真相", "两性", "不孕不育", "一图读懂", "肿瘤", "慢病", "营养", "母婴"]
    fileprivate let specialDataSource = SpecialTableDataSource()
    fileprivate let otherDataSource = OtherTableDataSoruce()
    
    fileprivate lazy var segmentScrollView: DXSegmentScrollView = { [unowned self] in
        let segment = DXSegmentScrollView(titles: self.topics)
        segment.delegate = self
        return segment
    } ()
    
    @objc private lazy var containerScrollView: UIScrollView = { [unowned self] in
        let container = UIScrollView()
        container.backgroundColor = DXColor.theme.color()
        container.isPagingEnabled = true
        container.delegate = self
        container.showsVerticalScrollIndicator = false
        container.showsHorizontalScrollIndicator = false
        return container
    } ()
    
    private lazy var refreshControl: UIRefreshControl = { [unowned self] in
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(DXHomeViewController.requestRecommend), for: .valueChanged)
        return refresh
    } ()
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: containerScrollView.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        collectionView.dataSource = self 
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.registerNib(DXRecomImageCell.self)
        collectionView.registerNib(DXRecomImageNoneCell.self)
        collectionView.registerNib(DXRecomSmallImageNoneCell.self)
        return collectionView
    } ()
    
    fileprivate var recommendDataList = [DXItemModel?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        title = "首页"
        
        setup()
        requestRecommend()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hideBottomHairline()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.showBottomHairline()
    }
    
    // MARK: Request
    @objc func requestRecommend() {
        if (recommendDataList.count == 0) {
             showLoadingHUD()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        DXNetworkManager.shareManager.requestRecommendList { (items, error) in
            guard let dataList = items, dataList.count > 0 else { return }
            self.recommendDataList = dataList
            self.hideLoadingHUD(animation: true)
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    // MARK: Action
    override func askDoctorButtonItemOnTapped(_ sender: UIBarButtonItem) {
        let askDoctorVC = DXAskDoctorViewController()
        askDoctorVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(askDoctorVC, animated: true)
    }
    
    // MARK: Setup
    func setup() {
        setupNaviBar()
        view.addSubview(segmentScrollView)
        view.addSubview(containerScrollView)

        let containerY = segmentScrollView.bottom
        let containerWidth = view.width
        let containerHight = view.height - containerY
        containerScrollView.frame = CGRect(x: 0, y: containerY, width: containerWidth, height: containerHight)
        containerScrollView.contentSize = CGSize(width: containerWidth * CGFloat(topics.count), height: containerHight)
        
        containerScrollView.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        collectionView.frame = containerScrollView.bounds
        
        setupTableViews()

        addObserver(self,
                    forKeyPath: #keyPath(DXHomeViewController.containerScrollView.contentOffset),
                    options: [.old, .new],
                    context: nil)
    }
    
    // 设置导航栏
     private func setupNaviBar() {
        let titleImageView = UIImageView.init(image: UIImage(named: "home_dxy_logo"))
        navigationItem.titleView = titleImageView;
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
    }

    // 专题、真相...
    private func setupTableViews() {
        for index in 1 ..< topics.count {
            let tableView = tableview(at: index)
            if let type = DXHomeTableViewType(rawValue: index) {
                switch type {
                case .recommend:break // "推荐"使用 collection view
                case .special:
                    specialDataSource.cellDelegate = self
                    tableView.dataSource = specialDataSource
                    tableView.registerNib(DXSpecialCell.self)
                case .other:
                    otherDataSource.cellDelegate = self
                    tableView.dataSource = otherDataSource
                    tableView.registerNib(DXOtherCell.self)
                }
            } else {
                tableView.dataSource = otherDataSource
                tableView.registerNib(DXOtherCell.self)
            }
            containerScrollView.addSubview(tableView)
        }
    }
    
    // 初始化 TableView
    private func tableview(at index: Int) -> UITableView {
        let origin = CGPoint(x: view.width * CGFloat(index), y: 0)
        let size = containerScrollView.size
        let tableView = UITableView(frame: CGRect(origin: origin, size: size), style: .plain)
        tableView.delegate = self
        tableView.tag = index
        tableView.separatorStyle = .none
        tableView.backgroundColor = DXColor.beige.color()
        tableView.allowsSelection = false
        
        // 下拉刷新
        let pullRefreshView = DXPullToRefresh(scrollView: tableView, hasNavigationBar: false)
        pullRefreshView.addRefreshingBlock({ () -> (Void) in
            let delayInSeconds: UInt64 = 2
            let popTime = DispatchTime.now() + Double(Int64(NSEC_PER_SEC * delayInSeconds)) / Double(NSEC_PER_SEC);
            
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: { () -> Void in
                pullRefreshView.stopRefreshing()
                tableView.reloadData()
            })
        })
        
        // 上拉刷新
        let pullRefreshFooterView = DXPullToRefreshFooter(scrollView: tableView, hasNavigationBar: false)
        pullRefreshFooterView.addRefreshingBlock({ () -> (Void) in
            let delayInSeconds: UInt64 = 2
            let popTime = DispatchTime.now() + Double(Int64(NSEC_PER_SEC * delayInSeconds)) / Double(NSEC_PER_SEC);
            
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: { () -> Void in
                pullRefreshFooterView.stopRefreshing()
                tableView.reloadData()
            })
        })
        return tableView
    }
    
    // MARK: KVO
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard let newOffset = change?[.newKey] as? CGPoint else { return }
        if keyPath == #keyPath(DXHomeViewController.containerScrollView.contentOffset) {
            let max = CGFloat(topics.count - 1) * view.width
            if newOffset.x > 0 && newOffset.x < max {
                let progress = newOffset.x / view.width
                segmentScrollView.labelTricksProgress(progress)
            }
        }
    }
}

// MARK: UITableViewDelegate
extension DXHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let tableViewType = DXHomeTableViewType(rawValue: tableView.tag) {
            return tableViewType.cellHeight
        } else {
            return DXHomeTableViewType.other.cellHeight
        }
    }
}

// MARK:- 专题，真相等的代理
extension DXHomeViewController: DXSpecialCellDelegate, DXOtherCelDelegate {
    func specialCellOnClick(_ cell: DXSpecialCell) {
        showTestWebView()
    }
    
    func otherCellOnClick(_ cell: DXOtherCell) {
        showTestWebView()
    }
    
    func showTestWebView() {
        let testVC = TestWebVeiwController()
        testVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(testVC, animated: true)
    }
}

// MARK:- SegmentScrollViewDelegate
extension DXHomeViewController: SegmentScrollViewDelegate {
    func segmentScrollView(_ segmentView: DXSegmentScrollView, tapAtIndex index: Int) {
        containerScrollView.setContentOffset(CGPoint(x: CGFloat(index) * view.width, y: 0), animated: true)
    }
}

// MARK:- 推荐页数据源和代理
extension DXHomeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let modelItem = recommendDataList[indexPath.row] else { return UICollectionViewCell() }
        let identifier = modelItem.showType.cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                      for: indexPath) as! BaseCollectionViewCell
        cell.configure(with: modelItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let indexItem = recommendDataList[indexPath.row] else {
            return
        }
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let webViewController = mainStoryboard.instantiateViewController(withIdentifier: "DXWebViewController") as! DXWebViewController;
        webViewController.hidesBottomBarWhenPushed = true
        webViewController.contentURL = indexItem.url
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = recommendDataList[indexPath.row] else {
            return .zero
        }
        return item.showType.size
    }
}

enum DXHomeTableViewType: Int {
    case recommend
    case special
    case other
    
    var cellHeight: CGFloat {
        switch self {
        case .recommend:
            return 630.0
        case .special:
            return 224.0
        case .other:
            return 89.0
        }
    }
}
