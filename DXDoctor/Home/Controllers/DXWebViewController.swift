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
        self.view.backgroundColor = UIColor.whiteColor()
        
        configWebView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DXWebViewController.reweakLoding), name: UIApplicationWillEnterForegroundNotification, object: nil)
        
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func configWebView() {
        
        let url: NSURL? = NSURL.init(string: contentURL);
        if url != nil {
            self.showLoadingHUD()
            
            let delayInSeconds: UInt64 = 1
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * delayInSeconds));
            
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                
                let request = NSURLRequest.init(URL: url!)
                self.webView?.loadRequest(request)
            })
        
        
           
        }
    }
    
    // Loading 后台唤醒
    func reweakLoding() {
        configWebView()
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
}

// MARK: UIWebViewDelegate
extension DXWebViewController {
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.hideLoadingHUD(animation: false)
         UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("load fail \(error)")
        self.hideLoadingHUD(animation: false)
         UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}