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
    fileprivate init() {}
    
    let  homeDataListUrl = "http://dxy.com/app/i/feed/index/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1"
    let session = URLSession.shared
    
    //
    public func requestRecommendList(_ result: ((_ items: [DXItemModel?]?, _ error: NSError?) -> Void)?) {
        
        guard let url = URL(string: homeDataListUrl) else {
            result?(nil, NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil))
            return;
        }
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                result?(nil, error! as NSError?)
            } else {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    if let dict = object as? [String: AnyObject] {
                        let results = DXItemModel.parseItemModelResult(dict);
                        DispatchQueue.main.async(execute: {
                            result?(results, nil)
//                            print("data: \(results)")
                        });
                    }
                } catch _ {
                    result?(nil, NSError(domain: DXDoctorErrorDomain,
                        code: DXDoctorRequestError.requestRecommentErr,
                        userInfo: nil))
                }
            }
        }) 
        task.resume()
    }

}

extension DXItemModel {
    static func parseItemModelResult(_ dictionary: [String: AnyObject]) -> [DXItemModel?]? {
        if let items = dictionary["data"]?["items"] as? [[String : AnyObject]] {
            
            return items.map{ DXItemModel(json: $0)}
            
        } else {
            return nil
        }
    }
}
