//  
//  AppCoordiantor.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class AppCoordiantor: BaseCoordinator {
    
    // MARK: Private properties
    
    private var window          : UIWindow
    private var rootCoordinator : CoordinatorProtocol? {
        didSet {
            rootCoordinator?.parrentCoordinator = self
        }
    }
    
    
    // MARK: Lifecycle
    
    init(window: UIWindow, rootCoordinator: CoordinatorProtocol) {
        self.window          = window
        self.rootCoordinator = rootCoordinator
    }

    @discardableResult
    override func start() -> UIViewController? {
        
        let rootViewController = rootCoordinator?.start()
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        return rootViewController
    }
    
    
    // MARK: Public methods
    
    override func switchRootCoordinator(_ coordinator: CoordinatorProtocol) {
        
        rootCoordinator = coordinator
        
        start()
    }
    
}


