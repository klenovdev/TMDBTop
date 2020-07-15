//
//  LoadingCell.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    // MARK: Defines
    
    public static let height: CGFloat = 44.0
    
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicatorView.startAnimating()
    }
    
}
