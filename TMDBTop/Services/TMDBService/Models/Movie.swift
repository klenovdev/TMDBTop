//
//  Movie.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

// NOTE: All properties are optional according to the API documentation located https://developers.themoviedb.org/3/movies/get-top-rated-movies

struct Movie: Codable {
    
    private static let baseImageURL: URL = URL(string: "https://image.tmdb.org/t/p/w500")!
    
    let popularity       : Double?
    let voteCount        : Int?
    let video            : Bool?
    let posterPath       : String?
    let id               : Int?
    let adult            : Bool?
    let backdropPath     : String?
    let originalLanguage : String?
    let originalTitle    : String?
    let genreIDS         : [Int]?
    let title            : String?
    let voteAverage      : Double?
    let overview         : String?
    let releaseDate      : String?

    var posterURL: URL? {
        
        if let path = posterPath {
            return Movie.baseImageURL.appendingPathComponent(path)
        }
        
        return nil
    }
    
    var backdropURL: URL? {
        
        if let path = backdropPath {
            return Movie.baseImageURL.appendingPathComponent(path)
        }
        
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount        = "vote_count"
        case video
        case posterPath       = "poster_path"
        case id
        case adult
        case backdropPath     = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle    = "original_title"
        case genreIDS         = "genre_ids"
        case title
        case voteAverage      = "vote_average"
        case overview
        case releaseDate      = "release_date"
    }
    
}
