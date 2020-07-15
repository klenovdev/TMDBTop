//
//  MovieTopRatedResponse.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

// NOTE: All properties are optional according to the API documentation located https://developers.themoviedb.org/3/movies/get-top-rated-movies

struct MovieTopRatedResponse: Codable {
    
    let page         : Int?
    let totalResults : Int?
    let totalPages   : Int?
    let results      : [Movie]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages   = "total_pages"
        case results
    }
    
}

