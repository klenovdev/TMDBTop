//
//  UITableView+Extension.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_ cell: T.Type) {
        
        register(UINib.init(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
    }
    
    func cell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
}
