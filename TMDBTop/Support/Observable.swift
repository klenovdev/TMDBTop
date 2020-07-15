//
//  Observable.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import Foundation

final class Observable<T> {
    
    // MARK: Public properties
    
    public var value: T {
        get {
            return observableValue
        }
        set {
            observableValue = newValue
        }
    }
    
    public var onChanged: ((T) -> Void)? {
        get {
            return onObservableValueChanged
        }
        
        set {
            onObservableValueChanged = newValue
        }
    }
    
    
    // MARK: Private properties
    
    private var observableValue: T {
        didSet {
            onObservableValueChanged?(observableValue)
        }
    }
    
    private var onObservableValueChanged: ((T) -> Void)? {
        didSet {
            onObservableValueChanged?(observableValue)
        }
    }
    
    
    // MARK: Lifecycle
    
    init(_ value: T) {
        
        observableValue = value
    }
    
}
