//
//  NetworkServiceProtocol.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {

    @discardableResult
    func get(_ url: URL,
             httpHeaders: [String : String]?,
             completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    @discardableResult
    func post(_ url: URL,
              httpHeaders: [String : String]?,
              httpBody: Data?,
              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    @discardableResult
    func request(_ url: URL,
                 httpMethod: NetworkServiceHttpMethod,
                 httpHeaders: [String : String]?,
                 httpBody: Data?,
                 completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
