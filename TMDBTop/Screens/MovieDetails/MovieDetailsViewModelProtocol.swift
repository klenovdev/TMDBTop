//  
//  MovieDetailsViewModelProtocol.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    
    var coordinator           : MovieDetailsCoordinatorProtocol? { get set }
    
    var movieBackdropImageUrl : URL?    { get }
    var movieTitle            : String? { get }
    var movieOverview         : String? { get }
    var movieOriginalTitle    : String? { get }
    var movieDetails          : String? { get }
}
