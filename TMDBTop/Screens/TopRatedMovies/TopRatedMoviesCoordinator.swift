//  
//  TopRatedMoviesCoordinator.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class TopRatedMoviesCoordinator: BaseCoordinator {
  
    // MARK: Private properties
    
    private var viewModel: TopRatedMoviesViewModelProtocol?

    
    // MARK: Lifecycle
    
    required init(viewModel: TopRatedMoviesViewModelProtocol?) {
        
        super.init()
        
        self.viewModel = viewModel
        self.viewModel?.coordinator = self
    }
    
    
    override func createViewController() -> UIViewController? {
        
        guard let viewModel = viewModel else {
            return nil
        }
        
        let viewController = TopRatedMoviesViewController(viewModel: viewModel)
        
        self.viewModel = nil
        
        return viewController
    }
    
}


// MARK: TopRatedMoviesCoordinatorProtocol implementation

extension TopRatedMoviesCoordinator: TopRatedMoviesCoordinatorProtocol {
    
    func showMovieDetails(_ movie: Movie) {
        
        let viewModel   = MovieDetailsViewModel(movie: movie)
        let coordinator = MovieDetailsCoordinator(viewModel: viewModel)

        startChild(coordinator: coordinator)
    }
    
}
