//
//  TMDBServiceProtocol.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

protocol TMDBServiceProtocol: class {
    
    func getTopRatedMovies(page: Int, completion: @escaping (Result<MovieTopRatedResponse, Error>) -> Void)
}
