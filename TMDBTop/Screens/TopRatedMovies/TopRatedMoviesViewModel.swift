//  
//  TopRatedMoviesViewModel.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

class TopRatedMoviesViewModel {
  
    // MARK: Public properties
    
    weak var coordinator: TopRatedMoviesCoordinatorProtocol?
    
    var state: Observable<TopRatedMoviesViewModelState> = .init(.loaded(movies: [], hasMore: true))
    
    
    // MARK: Private properties
    
    private let service       : TMDBServiceProtocol
    
    private var loadedMovies  : [Movie] = []
    private var nextPage      : Int     = 1
    private var hasMoreMovies : Bool    = true
    private var isLoadingMore : Bool    = false
    
    // MARK: Lifecycle
    
    init(service: TMDBServiceProtocol) {
        self.service = service
        
        loadMore()
    }
    
    deinit {
        coordinator?.finish()
    }
    
    
    // MARK: Public methods
    
    public func loadMore() {
        
        guard hasMoreMovies, !isLoadingMore else { return }
        
        isLoadingMore = true
                
        service.getTopRatedMovies(page: nextPage) { [weak self] (result) in
            do {
                self?.setLoadedState(response: try result.get())
            } catch let error {
                self?.setErrorState(error: error, tryAgainAction: { [weak self] in
                    self?.loadMore()
                })
            }
            self?.isLoadingMore = false
        }
    }
    
    
    // MARK: Private methods
    
    private func setLoadedState(response: MovieTopRatedResponse) {
        
        nextPage += 1
        
        loadedMovies.append(contentsOf: response.results ?? [])
        
        hasMoreMovies = response.totalResults ?? 0 > loadedMovies.count
        
        state.value = .loaded(movies: loadedMovies, hasMore: hasMoreMovies)
    }
    
    
    private func setErrorState(error: Error, tryAgainAction: (() -> Void)?) {
        
        state.value = .error(error: error, tryAgainAction: tryAgainAction)
    }
}


// MARK: TopRatedMoviesViewModelProtocol implementation

extension TopRatedMoviesViewModel: TopRatedMoviesViewModelProtocol {
    
    var title: String {
        return "Top Rated"
    }
    
    func onSelected(movie: Movie) {
        
        coordinator?.showMovieDetails(movie)
    }
    
}
