//
//  DXNetworkManager.swift
//  DXDoctor
//
//  Created by Jone on 16/6/6.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit
public let DXDoctorErrorDomain = "com.iostalk.DXDoctor.erro"
public struct DXDoctorRequestError {
    public static let requestRecommentErr = 1000
}

public struct DXNetworkManager {

    static let shareManager = DXNetworkManager()
    
    // This prevents others form using default '()' initializer for this class
    
    let session = NSURLSession.sharedSession()
    public func requestRecommendList(result: ((items: [DXItemModel?]?, error: NSError?) -> Void)?) {
        
        guard let url = NSURL(string: "http://dxy.com/app/i/feed/index/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1") else {
            result?(items: nil, error: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil))
            return;
        }
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if error != nil {
                result?(items: nil, error: error!)
            } else {
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    if let dict = object as? [String: AnyObject] {
                        let results = DXItemModel.parseItemModelResult(dict);
                        dispatch_async(dispatch_get_main_queue(), {
                            result?(items: results, error: nil)
                            print("data: \(results)")
                        });
                    }
                } catch _ {
                    result?(items: nil, error: NSError(domain: DXDoctorErrorDomain,
                        code: DXDoctorRequestError.requestRecommentErr,
                        userInfo: nil))

                }
            }
        }
        task.resume()
    }

}

extension DXItemModel {
    static func parseItemModelResult(dictionary: [String: AnyObject]) -> [DXItemModel?]? {
        if let items = dictionary["data"]?["items"] as? [[String : AnyObject]] {
            
            return items.map{ DXItemModel(json: $0)}
            
        } else {
            return nil
        }
    }
}