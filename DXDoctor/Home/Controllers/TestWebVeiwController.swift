//
//  DXRecomHeaderViewController.swift
//  DXDoctor
//
//  Created by Jone on 16/3/20.
//  Copyright © 2016年 Jone. All rights reserved.
// 代码创建WebView

/// 加载测试，查看loading动画类

import UIKit
import WebKit

class TestWebVeiwController: DXBaseViewController {

    var contentURL: String = " "
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
      
        webView = WKWebView(frame: self.view.bounds)
        self.view.addSubview(webView!)
    
        let url: URL? = URL.init(string: contentURL);
        if url != nil {
            let request = URLRequest.init(url: url!)
            webView?.load(request)
        }
        
//        self.showLoadingHUD()
    }
}
