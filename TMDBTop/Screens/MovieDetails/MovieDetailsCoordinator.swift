//  
//  MovieDetailsCoordinator.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class MovieDetailsCoordinator: BaseCoordinator {
  
    // MARK: Private properties
    
    private var viewModel: MovieDetailsViewModelProtocol?

    
    // MARK: Lifecycle
    
    required init(viewModel: MovieDetailsViewModelProtocol?) {
        super.init()
        
        self.viewModel = viewModel
        self.viewModel?.coordinator = self
    }
    
    override func start() -> UIViewController? {
        
        if let viewController = super.start() {
            
            parrentCoordinator?.pushViewController(viewController, animated: true)
            
            return viewController
        }

        return nil
    }
    
    override func createViewController() -> UIViewController? {
        
        guard let viewModel = viewModel else {
            return nil
        }
        
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        
        self.viewModel = nil
        
        return viewController
    }
    
}


// MARK: MovieDetailsCoordinatorProtocol implementation

extension MovieDetailsCoordinator: MovieDetailsCoordinatorProtocol {
    
}
