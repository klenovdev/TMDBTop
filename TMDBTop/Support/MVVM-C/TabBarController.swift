//  
//  TabBarController.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: Public properties
    
    public weak var coordinator: CoordinatorProtocol?
    
    
    // MARK: Lifecycle
    
    deinit {
        
        coordinator?.finish()
    }

}
