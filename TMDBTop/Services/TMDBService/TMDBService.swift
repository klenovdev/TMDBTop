//
//  TMDBService.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

class TMDBService {
    
    // MARK: Defines
    
    private static let apiKeyV3 : String = "96ac434a964aee1643f93f0cce99ee3d"
    private static let baseURL  : URL    =  URL(string: "https://api.themoviedb.org/3/")!
    
    
    // MARK: TMDBServiceError
    
    private struct TMDBServiceError: LocalizedError {
        
        var localizedDescription: String {
            return errorDescription ?? ""
        }
        
        var errorDescription: String? {
            return "An unknown error occurred"
        }
    }
    
    
    // MARK: Decoder
    
    private static let decoder: JSONDecoder = JSONDecoder()
    
    
    // MARK: Private properties
    
    private let networkService: NetworkServiceProtocol
    
    
    // MARK: Lifecycle
    
    init(networkService: NetworkServiceProtocol) {
        
        self.networkService = networkService
    }
    
    
    // MARK: Private static methods
    
    private static func process<T: Decodable>(response: (data: Data?, urlResponse: URLResponse?, error: Error?),
                                     completion: @escaping (Result<T, Error>) -> Void) {
        
        if let error = response.error {
            completion(.failure(error))
            return
        }
        
        guard let data = response.data else {
            completion(.failure(TMDBServiceError()))
            return
        }
        
        completion(Result { try TMDBService.decoder.decode(T.self, from: data) })
    }
    
}

// MARK: TMDBServiceProtocol implementation

extension TMDBService: TMDBServiceProtocol {
    
    func getTopRatedMovies(page: Int, completion: @escaping (Result<MovieTopRatedResponse, Error>) -> Void) {
        
        let url = TMDBService.baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent("top_rated")
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(TMDBServiceError()))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TMDBService.apiKeyV3),
            URLQueryItem(name: "language", value: Locale.current.languageCode ?? "en"),
            URLQueryItem(name: "region", value: Locale.current.regionCode ?? "US"),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let requestUrl = components.url else {
            completion(.failure(TMDBServiceError()))
            return
        }
        
        networkService.get(requestUrl, httpHeaders: nil) { data, response, error in
            TMDBService.process(response: (data, response, error), completion: completion)
        }
    }
    
}
