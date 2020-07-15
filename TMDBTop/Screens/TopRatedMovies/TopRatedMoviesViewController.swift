//  
//  TopRatedMoviesViewController.swift
//  TMDBTop
//
//  Created by Dmitry Klenov on 14.07.2020.
//  Copyright © 2020 Klenov. All rights reserved.
//

import UIKit

class TopRatedMoviesViewController: UITableViewController {
      
    // MARK: Private properties
    
    private var viewModel: TopRatedMoviesViewModelProtocol!
    

    // MARK: Lifecycle
    
    convenience init(viewModel: TopRatedMoviesViewModelProtocol) {
        self.init()
        
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: Private methods
    
    private func setup() {
        
        title = viewModel.title
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MovieCell.self)
        tableView.register(LoadingCell.self)
        tableView.register(ErrorCell.self)
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        viewModel.state.onChanged = { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch viewModel.state.value {
        case .loaded(movies: let movies, hasMore: _):
            if movies.indices.contains(indexPath.row) {
                viewModel.onSelected(movie: movies[indexPath.row])
            }
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.state.value {
        case .loaded(movies: let movies, hasMore: _):
            if movies.indices.contains(indexPath.row) {
                return (tableView.cell(indexPath: indexPath) as MovieCell).bind(movies[indexPath.row])
            } else {
                viewModel.loadMore()
                return tableView.cell(indexPath: indexPath) as LoadingCell
            }
        case .error(error: let error, tryAgainAction: let action):
            return (tableView.cell(indexPath: indexPath) as ErrorCell).bind((error, action))
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch viewModel.state.value {
        case .loaded(movies: let movies, hasMore: let hasMore):
            return hasMore ? movies.count + 1 : movies.count
        case .error:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch viewModel.state.value {
        case .loaded(movies: let movies, hasMore: _):
            return movies.indices.contains(indexPath.row) ? MovieCell.height : LoadingCell.height
        case .error:
            return ErrorCell.height
        }
        
    }
    
}
