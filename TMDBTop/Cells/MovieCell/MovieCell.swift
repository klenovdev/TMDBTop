//
//  MovieCell.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    // MARK: Defines
    
    public static let height: CGFloat = 100.0
    
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var posterImageView       : SelfLoadableImageView!
    @IBOutlet private weak var movieTitleLabel       : UILabel!
    @IBOutlet private weak var movieDescriptionLabel : UILabel!
    
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.removeImage()
        movieTitleLabel.text       = nil
        movieDescriptionLabel.text = nil
    }
    
    
    // MARK: Public methods
    
    public func bind(_ movie: Movie) -> Self {
        
        if let url = movie.posterURL {
            posterImageView.setImageWithURL(url)
        } else {
            posterImageView.removeImage()
        }
        
        movieTitleLabel.text       = movie.title
        movieDescriptionLabel.text = movie.overview
        
        return self
    }
    
}
