//  
//  TopRatedMoviesViewModelProtocol.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

protocol TopRatedMoviesViewModelProtocol {
    
    var coordinator : TopRatedMoviesCoordinatorProtocol? { get set }
    var state       : Observable<TopRatedMoviesViewModelState> { get }
    var title       : String { get }
    
    func loadMore()
    func onSelected(movie: Movie)
    
}
