//
//  DXHomeViewController.swift
//  DXDoctor
//
//  Created by Jone on 15/12/5.
//  Copyright © 2015年 Jone. All rights reserved.
//

import UIKit

enum DXHomeTableViewType: Int{
    case recommend = 0
    case special
    case other
}

let kRecomdCellIdentifier = "kRecomdCellIdentifier"
let kSpecialCellIdentifier = "kSpecialCellIdentifier"
let kOtherCellIdentifier = "kOtherCellIdentifier"

class DXHomeViewController: DXBaseViewController, DXSegmentViewDelegate, UIScrollViewDelegate {

    fileprivate let kRecommendCellHeight: CGFloat = 630.0
    fileprivate let kSpecialCellHeight: CGFloat = 224.0
    fileprivate let kOtherCellHeight: CGFloat = 89.0
    
    fileprivate let SEGMENT_HEI: CGFloat = 30.0;
    fileprivate var containerScrollView: UIScrollView!
    fileprivate var segmentView: DXSegmentView?
    fileprivate var topicItems: [String] = []
    
//    var recommendDataSource: DXRecomTableDataSource!
    var specialDataSource: DXSpecialTableDataSource!
    var otherDataSource: DXOtherTableDataSoruce!
    
    var recommendDataList: [DXItemModel?]?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "首页"
        
        setupNaviBar()
        setupSegmentView()
        setupScrollView()
        
        configDataSourceForTableView()
        setupTableViews()
        
        // 请求推荐页数据
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
    
    // Mark: Request
    @objc private func requestRecommend() {
        if (recommendDataList?.count == nil) {
             showLoadingHUD()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
            DXNetworkManager.shareManager.requestRecommendList { (items, error) in
                if ((error) != nil) { return }
                self.recommendDataList = items
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.hideLoadingHUD(animation: true)
                self.refreshControl.endRefreshing()
                self.collectionView.reloadData()
        }
    }

    // 初始化 专题、真相... 数据源
    private func configDataSourceForTableView() {
//        recommendDataSource = DXRecomTableDataSource() // 不可使用 lazy
//        recommendDataSource.cellDelegate = self
        
        specialDataSource   = DXSpecialTableDataSource()
        specialDataSource.cellDelegate = self
        
        otherDataSource     = DXOtherTableDataSoruce()
        otherDataSource.cellDelegate = self
    }
    
    // MARK: View
    
    // 设置导航栏
     private func setupNaviBar() {
        let titleImageView = UIImageView.init(image: UIImage.init(named: "home_dxy_logo"))
        navigationItem.titleView = titleImageView;
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: nil)
        setUpNavigationBar()
    }
    
    // 初始化选项栏
    func setupSegmentView() {
        topicItems = ["推荐", "专题", "真相", "慢病","一图读懂", "肿瘤" /*, "营养" */]
        let frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: SEGMENT_HEI)
        segmentView = DXSegmentView.init(titles: topicItems, iframe: frame);
        segmentView!.backgroundColor = UIColor.white
        segmentView!.delegate = self
        view.addSubview(segmentView!)
    }
    
    // 初始化左右滚动内容视图
    func setupScrollView() {
        let originY = (segmentView?.height)! + (segmentView?.y)!
        containerScrollView = UIScrollView.init(frame: CGRect.zero)
        containerScrollView.frame           = CGRect(x: 0, y: originY, width: view.width, height: view.height - originY)
        containerScrollView.contentSize     = CGSize(width: CGFloat(topicItems.count) * view.width, height: (containerScrollView.height));
        containerScrollView.backgroundColor = DXSettingManager.manager.beigeWhiteColor
        containerScrollView.isPagingEnabled   = true;
        containerScrollView.bounces         = false
        containerScrollView.delegate        = self;
        containerScrollView.showsVerticalScrollIndicator = false
        containerScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(containerScrollView)
        
    }
    
    // 推荐页
    private let middleGap: CGFloat = 0.5;
    private var _collectionView: UICollectionView!
    private var collectionView: UICollectionView  {
        get {
            if (_collectionView != nil) {return _collectionView! }
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = middleGap
            layout.minimumInteritemSpacing = 0
            _collectionView = UICollectionView.init(frame: containerScrollView.bounds, collectionViewLayout: layout)
            _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
            _collectionView.dataSource = self // datasource class no effect
            _collectionView.delegate = self;
            _collectionView.backgroundColor = UIColor.white
            _collectionView.addSubview(self.refreshControl);
            
            let recomImageCell = UINib.init(nibName: "DXRecomImageCell", bundle: nil)
            _collectionView.register(recomImageCell, forCellWithReuseIdentifier: "DXRecomImageCell")
            
            let recomImageNoneCell = UINib.init(nibName: "DXRecomImageNoneCell", bundle: nil)
            _collectionView.register(recomImageNoneCell, forCellWithReuseIdentifier: "DXRecomImageNoneCell")
            
            let recomSmallImageNoneCell = UINib.init(nibName: "DXRecomSmallImageNoneCell", bundle: nil)
            _collectionView.register(recomSmallImageNoneCell, forCellWithReuseIdentifier: "DXRecomSmallImageNoneCell")
            
            return _collectionView;
        }
    }
    
    private var _refreshControl: UIRefreshControl!
    private var refreshControl: UIRefreshControl {
        get {
            if (_refreshControl != nil) {return _refreshControl}
            _refreshControl = UIRefreshControl()
            _refreshControl.addTarget(self, action: #selector(DXHomeViewController.requestRecommend), for: .valueChanged)
            return _refreshControl
        }
    }
    
    // 专题、真相...
    private func setupTableViews() {
        
        for index in 0 ..< topicItems.count {
            let tableView = createTableView(index: index)
            if let type = DXHomeTableViewType(rawValue: index) {
                switch type {
                case .recommend:
                    self.collectionView.frame = CGRect(x: 0, y: 0, width: containerScrollView.width, height: containerScrollView.height)
                    containerScrollView.addSubview(self.collectionView)
                case .special:
                    tableView!.dataSource = specialDataSource
                    tableView!.register(UINib.init(nibName: "DXSpecialCell", bundle: nil), forCellReuseIdentifier: kSpecialCellIdentifier)
                default:
                    tableView!.dataSource = otherDataSource
                    tableView!.register(UINib.init(nibName: "DXOtherCell", bundle: nil), forCellReuseIdentifier: kOtherCellIdentifier)
                }
            }else {
                // 第四项
                tableView!.dataSource = otherDataSource
                tableView!.register(UINib.init(nibName: "DXOtherCell", bundle: nil), forCellReuseIdentifier: kOtherCellIdentifier)
            }
        }
    }
    
    // Init table view
    private func createTableView(index: Int) -> UITableView? {
        if (index == 0) {
            return nil
        }
        
        let tableView = UITableView.init(frame: CGRect(x: CGFloat(index) * view.width, y: 0, width: containerScrollView.width, height: (containerScrollView.height)))
        tableView.delegate = self
        tableView.tag = index
        tableView.separatorStyle = .none
        tableView.backgroundColor = DXSettingManager.manager.beigeWhiteColor
        tableView.allowsSelection = false
        containerScrollView.addSubview(tableView)
        
        // 初始化下拉刷新控件
        let pullRefreshView = DXPullToRefresh.init(scrollView: tableView, hasNavigationBar: false)
        pullRefreshView.addRefreshingBlock({ () -> (Void) in
            
            // 下拉刷新操作
            let delayInSeconds: UInt64 = 2
            let popTime = DispatchTime.now() + Double(Int64(NSEC_PER_SEC * delayInSeconds)) / Double(NSEC_PER_SEC);
            
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: { () -> Void in
                pullRefreshView.stopRefreshing()
            })
        })
        
        let pullRefreshFooterView = DXPullToRefreshFooter.init(scrollView: tableView, hasNavigationBar: false)
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
    
    // MARK: DXAskdoctorViewDelegate
    override func askDoctorButtonItemOnTapped(_ sender: UIButton) {
        
        let askDoctorVC = DXAskDoctorViewController()
        askDoctorVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(askDoctorVC, animated: true)
    }

}


// MARK: UITableViewDelegate

extension DXHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let tableViewType = DXHomeTableViewType(rawValue: tableView.tag) {
            
            switch tableViewType {
                
            case .recommend:
                return kRecommendCellHeight
            case .special:
                return kSpecialCellHeight
            default:
                return kOtherCellHeight
            }
        }else {
            return kOtherCellHeight
        }
    }

}

// MARK: 专题，真相等的代理

extension DXHomeViewController: DXSpecialCellDelegate, DXOtherCelDelegate {
    
    // Recommend
//    func headerViewOnClick(_ cell: DXRecommendCell) {
//        showLoadingWebView(cell)
//    }
//    
//    func leftViewOnClick(_ cell: DXRecommendCell) {
//        showLoadingWebView(cell)
//    }
//    
//    func rightViewOnClick(_ cell: DXRecommendCell) {
//        showLoadingWebView(cell)
//    }
//    
//    func footerViewOnClick(_ cell: DXRecommendCell) {
//        showLoadingWebView(cell)
//    }
    
    // Special
    func specialCellOnClick(_ cell: DXSpecialCell) {
        showTestWebView()
    }
    
    // Other
    func otherCellOnClick(_ cell: DXOtherCell) {
        showTestWebView()
    }
    
    // Common
//    func showLoadingWebView(_ cell: DXRecommendCell) {
//        
//        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let recommHeaderVC = mainStoryboard.instantiateViewController(withIdentifier: "DXWebViewController") as! DXWebViewController;
//        
//        recommHeaderVC.hidesBottomBarWhenPushed = true
//        recommHeaderVC.contentURL = (cell.dataModel?.headerUrl)!
//        self.navigationController?.pushViewController(recommHeaderVC, animated: true)
//        
//    }
    
    func showTestWebView() {
        let testVC = TestWebVeiwController()
        testVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(testVC, animated: true)
    }
}

// MARK: DXSegmentViewDelegate
extension DXHomeViewController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard scrollView == containerScrollView else {
            return
        }
        
        if (!scrollView.isTracking) {
            let curPage: Int = Int(scrollView.contentOffset.x / view.width)
            segmentView?.topicItemTappedAtIndex(curPage)
        }
    }
    
    func segmentItemOnClickedAtIndex(_ index: Int) {
        containerScrollView.setContentOffset(CGPoint(x: CGFloat(index) * view.width, y: 0), animated: true)
    }

}

// MARK: 推荐页数据源和代理
extension DXHomeViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexItem = recommendDataList![(indexPath as NSIndexPath).row] as DXItemModel!
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let webViewController = mainStoryboard.instantiateViewController(withIdentifier: "DXWebViewController") as! DXWebViewController;
        webViewController.hidesBottomBarWhenPushed = true
        webViewController.contentURL = (indexItem?.url)!
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let itemHeight:CGFloat = 210.0
        if let item = recommendDataList![(indexPath as NSIndexPath).row] {
            switch item.showType {
            case .image:
                return CGSize(width: collectionView.width, height: itemHeight)
            case .imageNone:
                return CGSize(width: collectionView.width, height: itemHeight)
            case .smallImageNone:
                return CGSize(width: (collectionView.width)/2, height: itemHeight)
            }
        }else {
            return CGSize.zero
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (recommendDataList?.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell!
        let indexItem = recommendDataList![(indexPath as NSIndexPath).row] as DXItemModel!
            switch indexItem!.showType {
            case .image:
             
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DXRecomImageCell", for: indexPath)
                if let _cell = cell as? DXRecomImageCell {
                    _cell.configWithModel(indexItem!)
                }
                
            case .imageNone:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DXRecomImageNoneCell", for: indexPath)
                if let _cell = cell as? DXRecomImageNoneCell {
                    _cell.configWithModel(indexItem!)
                }

            case .smallImageNone:
                
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DXRecomSmallImageNoneCell", for: indexPath)
                if let _cell = cell as? DXRecomSmallImageNoneCell {
                    _cell.configWithModel(indexItem!)
                }
            }
        cell.contentView.backgroundColor = UIColor.lightGray
        return cell
    }
}
