//
//  DXRecomHeaderViewController.swift
//  DXDoctor
//
//  Created by Jone on 16/3/20.
//  Copyright © 2016年 Jone. All rights reserved.
// 代码创建WebView

/// 加载测试，查看loading动画类

import UIKit

class TestWebVeiwController: DXBaseViewController, UIWebViewDelegate {

    var contentURL: String = " "
    var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
      
        webView = UIWebView.init(frame: self.view.bounds)
        webView?.delegate = self
        self.view.addSubview(webView!)
    
        
        let url: URL? = URL.init(string: contentURL);
        if url != nil {
            let request = URLRequest.init(url: url!)
            webView?.loadRequest(request)
            
        }
        
        self.showLoadingHUD()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

// MARK: UIWebViewDelegate
extension TestWebVeiwController {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
//        self.hideLoadingHUD(animation: false)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    }
}
