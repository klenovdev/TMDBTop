//  
//  TopRatedMoviesCoordinatorProtocol.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

protocol TopRatedMoviesCoordinatorProtocol: CoordinatorProtocol {
  
    func showMovieDetails(_ movie: Movie)
}
