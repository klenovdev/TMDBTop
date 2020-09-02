//
//  Data+Extension.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

extension Data {
    
    public var prettyPrintedJsonString: String? {
        
        if let json = try? JSONSerialization.jsonObject(with: self, options: []) {
            if let prettyPrintData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                return String(bytes: prettyPrintData, encoding: .utf8)
            }
        }
        
        return utf8Sting
    }
    
    var utf8Sting: String? {
        
        return String(data: self, encoding: .utf8)
    }
    
}
