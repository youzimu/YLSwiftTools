//
//  YLURL.swift
//  YLSwiftTools
//
//  Created by youzimu on 2022/4/15.
//

import Foundation

public extension URL {
    
    /// 获取url里的键值对
     var yl_urlParameters : [String: String]? {
            guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
            return queryItems.reduce(into: [String: String]()) { (result, item) in
                result[item.name] = item.value
            }
        }
}
