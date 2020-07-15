//
//  TopRatedMoviesViewModelState.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

enum TopRatedMoviesViewModelState {
    
    case loaded(movies: [Movie], hasMore: Bool)
    case error(error: Error, tryAgainAction: (() -> Void)?)
}
