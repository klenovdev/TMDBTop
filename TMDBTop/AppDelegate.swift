//
//  AppDelegate.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Public properties
    
    public var window: UIWindow?

    
    // MARK: Private properties
    
    private var appCoordinator: AppCoordiantor!
    
    
    // MARK: Public methods
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window         = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = createAppCoordinator(window: window!)
        
        appCoordinator.start()
        
        return true
    }
    

    // MARK: Private methods
    
    private func createAppCoordinator(window: UIWindow) -> AppCoordiantor {
        
        let tmdbService               = TMDBService(networkService: NetworkService.shared)
        let topRatedMoviesViewModel   = TopRatedMoviesViewModel(service: tmdbService)
        let topRatedMoviesCoordinator = TopRatedMoviesCoordinator(viewModel: topRatedMoviesViewModel)
        let navigationCoordinator     = NavigationCoordinator(rootCoordinator: topRatedMoviesCoordinator)
        let tabbarCoordinator         = TabBarCoordinator(rootCoordinators: [navigationCoordinator])
        
        return AppCoordiantor(window: window, rootCoordinator: tabbarCoordinator)
    }


}

