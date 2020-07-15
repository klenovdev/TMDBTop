//  
//  MovieDetailsViewModel.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
  
    // MARK: Public properties
    
    weak var coordinator: MovieDetailsCoordinatorProtocol?
    
    
    // MARK: Private properties
    
    private let movie: Movie
    
    // MARK: Lifecycle
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    deinit {
        
        coordinator?.finish()
    }
    
}


// MARK: MovieDetailsViewModelProtocol implementation

extension MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    var movieTitle: String? {
        return movie.title
    }
    
    var movieBackdropImageUrl: URL? {
        return movie.backdropURL
    }
    
    var movieOverview: String? {
        return movie.overview
    }
    
    var movieOriginalTitle: String? {
        return movie.originalTitle
    }
    
    var movieReleaseDate: String? {
        return movie.releaseDate
    }
    
    var movieDetails: String? {
        
        var meta: String = ""
        
        if let releaseDate = movie.releaseDate {
            meta += "Release date: " + releaseDate
        }
        
        if let voteCount = movie.voteCount {
            if !meta.isEmpty {
                meta += "\n"
            }
            
            meta += "Votes: " + String(voteCount)
        }
        
        if let voteAverage = movie.voteAverage {
            if !meta.isEmpty {
                meta += "\n"
            }
            
            meta += "Vote average: " + String(voteAverage)
        }
        
        return meta
    }
    
}
