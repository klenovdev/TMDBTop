//
//  ErrorCell.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class ErrorCell: UITableViewCell {

    // MARK: Defines
    
    public static let height = UITableView.automaticDimension
    
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var errorDescriptionLabel: UILabel!
    

    // MARK: Private properties
    
    private var tryAgainAction: (() -> Void)?
    
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        errorDescriptionLabel.text = nil
        tryAgainAction = nil
    }
    
    
    // MARK: Public methods
    
    public func bind(_ model: (error: Error, tryAgainAction: (() -> Void)?)) -> Self {
        
        self.tryAgainAction = model.tryAgainAction
        self.errorDescriptionLabel.text = model.error.localizedDescription
        
        return self
    }
    
    
    // MARK: Private methods
    
    @IBAction
    private func onTryAgain() {
        
        tryAgainAction?()
    }
    
}
