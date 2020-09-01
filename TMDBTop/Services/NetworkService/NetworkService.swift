//
//  NetworkService.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

final class NetworkService {
    
    // MARK: Shared
    
    public static let shared: NetworkService = NetworkService()
    
    
    // MARK:  Private Methods
    
    private func sendRequest(_ url: URL,
                             httpMethod: NetworkServiceHttpMethod,
                             httpHeaders: [String : String]? = nil,
                             httpBody: Data? = nil,
                             completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)-> URLSessionDataTask {
        
        var request = URLRequest(url: url,
                                 cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData,
                                 timeoutInterval: 30.0)
        
        request.httpMethod = httpMethod.rawValue
        
        for (key, value) in httpHeaders ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = httpBody
        
        return sendRequest(request, completionHandler: completionHandler)
    }
    
    private func sendRequest(_ request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)-> URLSessionDataTask {
        
        
        type(of: self).debugLog(request)
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            if let nsError = error as NSError? {
                guard nsError.code != -999 else {
                    return
                }
            }
            
            #if DEBUG
            type(of: self).debugLog(data: data, response: response, error: error, originUrl: request.url)
            #endif
            
            DispatchQueue.main.async(execute: {
                completionHandler(data, response, error)
            })
        }
        
        task.resume()
        
        return task
    }
    
    private static func debugLog(data: Data?, response: URLResponse?, error: Error?, originUrl: URL?) {
        
        debugLog(String(format:"REQUEST URL: %@", originUrl?.absoluteURL.absoluteString ?? "UNKNOWN"))
        debugLog(String(format:"RESPONSE URL: %@", response?.url?.absoluteURL.absoluteString ?? "UNKNOWN"))
        debugLog(String(format:"RESPONSE JSON DATA: %@", data?.prettyPrintedJsonString ?? "NOT A JSON"))
        
        if (error != nil) {
            debugLog(String(format:"ERROR: %@", error?.localizedDescription ?? "nil"))
        }
    }
    
    private static func debugLog(_ request: URLRequest) {
        
        debugLog(String(format:"REQUEST URL: %@", request.url?.absoluteURL.absoluteString ?? "UNKNOWN"))
        debugLog(String(format:"REQUEST HTTPMethod: %@", request.httpMethod ?? "UNKNOWN"))
        debugLog(String(format:"REQUEST HTTPBody: %@", request.httpBody?.prettyPrintedJsonString ?? "nil"))
        debugLog(String(format:"REQUEST HTTPHeaders: %@", request.allHTTPHeaderFields ?? [:]))
    }
    
    private static func debugLog(_ value: String) {
        #if DEBUG
        print("[Network Service]: ", value)
        #endif
    }
}


// MARK:  NetworkServiceProtocol implementation

extension NetworkService: NetworkServiceProtocol {
    
    func get(_ url: URL,
             httpHeaders: [String : String]?,
             completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return sendRequest(url,
                           httpMethod: .GET,
                           httpHeaders: httpHeaders,
                           completionHandler: completionHandler)
    }
    
    func post(_ url: URL,
              httpHeaders: [String : String]?,
              httpBody: Data?,
              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return sendRequest(url,
                           httpMethod: .POST,
                           httpHeaders: httpHeaders,
                           httpBody:httpBody,
                           completionHandler: completionHandler)
    }
    
    func request(_ url: URL,
                 httpMethod: NetworkServiceHttpMethod,
                 httpHeaders: [String : String]?,
                 httpBody: Data?,
                 completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return sendRequest(url,
                           httpMethod: httpMethod,
                           httpHeaders: httpHeaders,
                           httpBody:httpBody,
                           completionHandler: completionHandler)
    }
    
}
