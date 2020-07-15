//
//  ImageStorageServiceProtocol.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

protocol ImageStorageServiceProtocol: class {
    
    func storeImage(image: UIImage, named: String)
    func hasImage(named: String) -> Bool
    func getImage(named: String) -> UIImage?
    func loadImage(named: String, completion: @escaping ((UIImage?) -> Void))
}
