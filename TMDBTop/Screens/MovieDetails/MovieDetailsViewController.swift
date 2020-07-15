//  
//  MovieDetailsViewController.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
  
    // MARK: IBOutlets
    
    @IBOutlet private weak var backdropImageView       : SelfLoadableImageView!
    @IBOutlet private weak var movieOriginalTitleLabel : UILabel!
    @IBOutlet private weak var movieDetailsLabel       : UILabel!
    @IBOutlet private weak var movieOverviewLabel      : UILabel!
    
    
    // MARK: Private properties
    
    private var viewModel: MovieDetailsViewModelProtocol!
    
    
    // MARK: Lifecycle
    
    convenience init(viewModel: MovieDetailsViewModelProtocol) {
        self.init(nibName: "MovieDetailsViewController", bundle: nil)
        
        self.viewModel = viewModel
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    
    // MARK: Private methods
    
    private func setup() {
        
        title = viewModel.movieTitle
        
        if let url = viewModel.movieBackdropImageUrl {
            backdropImageView.setImageWithURL(url)
        }
        
        movieOverviewLabel.text = viewModel.movieOverview
        movieOriginalTitleLabel.text = viewModel.movieOriginalTitle
        movieDetailsLabel.text = viewModel.movieDetails
    }
    
}
