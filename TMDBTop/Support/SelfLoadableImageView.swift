//
//  SelfLoadableImageView.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class SelfLoadableImageView: UIImageView {

    // MARK: Image cache
    
    private static var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 25
        return cache
    }()
    
    
    // MARK: Public properties
    
    @IBInspectable
    public var isActivityIndicatorStyleWhite: Bool = true
    public var imageHandler: ((UIImage) -> Void)?
    
    
    // MARK: Private properties
    
    private let networkService        : NetworkServiceProtocol      = NetworkService()
    private let storage               : ImageStorageServiceProtocol = ImageStorageService()
    private var imageUrl              : URL?
    private var activityIndicatorView : UIActivityIndicatorView?
    private var currentLoadTask       : URLSessionDataTask? {
        didSet {
            currentLoadTask == nil ? hideLoadingIndicator() : showLoadingIndicator()
        }
    }

    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addObserver(self, forKeyPath: "image", options: [.new, .old, .initial, .prior], context: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicatorView?.frame = bounds
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        activityIndicatorView?.frame = bounds
    }
    
    deinit {
        
        removeObserver(self, forKeyPath: "image")
    }
    
    
    // MARK: Public methods
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let newImage = image {
            imageHandler?(newImage)
        }
    }
    
    public func setImageWithURL(_ url: URL) {
  
        if imageUrl?.absoluteString == url.absoluteString {
            return
        }
        
        image = nil
        
        currentLoadTask?.cancel()
        currentLoadTask = nil
        
        imageUrl = url
        
        getImageFromCache(url: NSString(string: url.absoluteString)) { [weak self] (image) in
            if let cachedImage = image {
                self?.image = cachedImage
                self?.imageHandler?(cachedImage)
            } else {
                self?.loadImageFromNetwork(url: url, completion: { [weak self] (loadedImage) in
                    guard url == self?.imageUrl else { return }
                    self?.addImageToCache(url: NSString(string: url.absoluteString), image: loadedImage)
                    self?.image = loadedImage
                    self?.imageHandler?(loadedImage)
                })
            }
        }
        
    }
    
    public func removeImage() {
        
        currentLoadTask?.cancel()
        currentLoadTask = nil
        imageUrl = nil
        image = nil
    }
    
    
    // MARK: Private methods
    
    private func getImageFromCache(url: NSString, comletion: @escaping (UIImage?) -> Void){
        
        if let cached = type(of: self).imageCache.object(forKey: url) {
            comletion(cached)
            return
        }
        
        if storage.hasImage(named: url as String) {
            storage.loadImage(named: url as String) { (image) in
                if let image = image {
                    type(of: self).imageCache.setObject(image, forKey: url)
                }
                comletion(image)
            }
            return
        }
        
        comletion(nil)
    }
    
    private func addImageToCache(url: NSString, image: UIImage) {
        
        type(of: self).imageCache.setObject(image, forKey: url)
        
        storage.storeImage(image: image, named: url as String)
    }
    
    private func loadImageFromNetwork(url: URL, completion: @escaping (UIImage) -> Void) {
        
        currentLoadTask = networkService.get(url, httpHeaders: nil, completionHandler: { [weak self] (data, _, error) in
            guard error == nil, let data = data else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: { [weak self] in
                    self?.loadImageFromNetwork(url: url, completion: completion)
                })
                return
            }
            
            guard let image = UIImage(data: data) else {
                
                self?.currentLoadTask = nil
                
                return
            }
            
            self?.currentLoadTask = nil
            
            completion(image)
        })
    }
    
    private func showLoadingIndicator() {
        
        guard activityIndicatorView == nil else {
            return
        }
        
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.color = isActivityIndicatorStyleWhite ? .white : .gray
        loadingIndicator.frame = bounds
        
        
        activityIndicatorView = loadingIndicator
        
        addSubview(loadingIndicator)
        
        loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {

        guard activityIndicatorView != nil else {
            return
        }

        activityIndicatorView?.stopAnimating()
        activityIndicatorView?.isHidden = true
        activityIndicatorView?.removeFromSuperview()
    }
    
}




