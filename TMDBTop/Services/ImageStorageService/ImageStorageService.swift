//
//  ImageStorageService.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

final class ImageStorageService: ImageStorageServiceProtocol {

    // MARK: Public methods
    
    public func storeImage(image: UIImage, named: String) {
        
        do {
            let fileURL = try getFileURL(named: named)
            DispatchQueue.global().async {
                if let imageData = image.pngData() {
                    do {
                        try imageData.write(to: fileURL)
                    } catch let error {
                        print("ImageStorageService.storeImage:Named - Error: \(error.localizedDescription)")
                    }
                }
            }
        } catch let error {
            print("ImageStorageService.storeImage:named - Error: \(error.localizedDescription)")
        }
    }
    
    
    public func hasImage(named: String) -> Bool {
        
        do {
            return FileManager.default.fileExists(atPath: try getFileURL(named: named).path)
        } catch let error {
            print("ImageStorageService.hasImage:named - Error: \(error.localizedDescription)")
        }
        
        return false
    }
    
    public func getImage(named: String) -> UIImage? {
        
        do {
            let data = try Data(contentsOf: try getFileURL(named: named))
            return UIImage(data: data)
        } catch let error {
            print("ImageStorageService.getImage:named - Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func loadImage(named: String, completion: @escaping ((UIImage?) -> Void)) {

        do {
            let fileURL = try getFileURL(named: named)
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                completion(nil)
                return
            }
            DispatchQueue.global().sync {
                do {
                    let imageData = try Data.init(contentsOf: fileURL)
                    DispatchQueue.main.async {
                        completion(UIImage(data: imageData))
                    }
                } catch let error {
                    print("ImageStorageService.storeImage:Named - Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            
        } catch let error {
            completion(nil)
            print("ImageStorageService.loadImage:named:completion: - Error: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: Private methods
    
    private func getFileURL(named: String) throws -> URL {
        
        return try getCachesDirectoryURL().appendingPathComponent(named.replacingOccurrences(of: "/", with: "-"))
    }
    
    private func getCachesDirectoryURL() throws -> URL {
        
        try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
    }
    
}
