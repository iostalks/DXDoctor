//
//  DXWebViewController.swift
//  DXDoctor
//
//  Created by Jone on 16/3/21.
//  Copyright © 2016年 Jone. All rights reserved.
//  Storybord create WebView

import UIKit

class DXWebViewController: DXBaseViewController, UIWebViewDelegate {
    
    var contentURL: String = ""
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        configWebView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(DXWebViewController.reweakLoding), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func configWebView() {
        if let url: URL = URL(string: contentURL) {
            self.showLoadingHUD()
            
            let popTime = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: popTime, execute: { () -> Void in
                let request = URLRequest(url: url)
                self.webView?.loadRequest(request)
            })
        }
    }
    
    // Loading 后台唤醒
    @objc func reweakLoding() {
        configWebView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
}

// MARK: UIWebViewDelegate
extension DXWebViewController {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hideLoadingHUD(animation: false)
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("load fail \(error)")
        self.hideLoadingHUD(animation: false)
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
