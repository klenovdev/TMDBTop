//  
//  NavigationCoordinator.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class NavigationCoordinator: BaseCoordinator {

    // MARK: Private properties
    
    private var rootCoordinator: CoordinatorProtocol? {
        didSet {
            rootCoordinator?.parrentCoordinator = self
        }
    }
    
    
    // MARK: Lifecycle
    
    init(rootCoordinator: CoordinatorProtocol?) {
        super.init()
        
        self.rootCoordinator = rootCoordinator
    }
    
    override func createViewController() -> UIViewController? {
        
        rootCoordinator?.parrentCoordinator = self
        
        if let navigationRootViewController = rootCoordinator?.start() {
            let navigationViewController = NavigationController(rootViewController: navigationRootViewController)
            navigationViewController.coordinator = self
            return navigationViewController
        }
        
        return nil
    }
    

    // MARK: Public methods
    
    override func switchNavigationRootCoordinator(_ coordinator: CoordinatorProtocol, animated: Bool) {
        
        rootCoordinator = coordinator
        
        if let navigationController = viewController as? NavigationController, let viewController = coordinator.start() {
            navigationController.setViewControllers([viewController], animated: animated)
        }
    }
    
}
