//
//  NetworkServiceHttpMethod.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

public enum NetworkServiceHttpMethod {
    
    case GET, POST
    case other(String)
    
    var rawValue: String {
        switch self {
        case .GET               : return "GET"
        case .POST              : return "POST"
        case .other(let method) : return method
        }
    }
    
    init(rawValue: String) {
        switch rawValue {
        case "GET"  : self = .GET
        case "POST" : self = .POST
        default     : self = .other(rawValue)
        }
    }
}
