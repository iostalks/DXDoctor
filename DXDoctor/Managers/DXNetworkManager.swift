//
//  DXNetworkManager.swift
//  DXDoctor
//
//  Created by Jone on 16/6/6.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

let DXDoctorErrorDomain = "com.iostalk.DXDoctor.erro"
//struct DXDoctorRequestError {
//    public static let requestRecommentErr = 1000
//}

enum DXDoctorRequestError: Error {
    case requestError
    case parserError
}

struct DXNetworkManager {
    static let shareManager = DXNetworkManager()
    private init() {}
    
    private let homeDataListUrl = "http://dxy.com/app/i/feed/index/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1"
    private let session = URLSession.shared
    
    func requestRecommendList(_ result: ((_ items: [DXItemModel?]?, _ error: DXDoctorRequestError?) -> Void)?) {
        guard let url = URL(string: homeDataListUrl) else {
            result?(nil, .requestError)
            return;
        }
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard let dataObject = data else {
                result?(nil, .requestError)
                return
            }
            do {
                let object = try JSONSerialization.jsonObject(with: dataObject, options: .allowFragments)
                if let dict = object as? [String: AnyObject] {
                    let results = DXItemModel.parseItemModelResult(dict);
                    DispatchQueue.main.async(execute: {
                        result?(results, nil)
                        // print("data: \(results)")
                    });
                }
            } catch _ {
                result?(nil, .parserError)
            }
        }) 
        task.resume()
    }
}

extension DXItemModel {
    static func parseItemModelResult(_ dictionary: [String: AnyObject]) -> [DXItemModel?]? {
        if let items = dictionary["data"]?["items"] as? [[String : AnyObject]] {
            return items.map{ DXItemModel(json: $0) }
        } else {
            return nil
        }
    }
}
