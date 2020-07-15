//  
//  NavigationController.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    // MARK: Public properties
    
    public weak var coordinator: CoordinatorProtocol?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return viewControllers.last?.preferredStatusBarStyle ?? .default
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    deinit {
        
        coordinator?.finish()
    }
    
}

extension NavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return viewControllers.count > 1
    }
    
}
