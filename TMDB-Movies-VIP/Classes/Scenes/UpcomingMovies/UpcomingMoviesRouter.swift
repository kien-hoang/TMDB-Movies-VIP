//
//  UpcomingMoviesRouter.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//

import UIKit

protocol ViewToRouterUpcomingMoviesProtocol: AnyObject {
    func navigateToEditMovieView()
}

protocol DataPassingUpcomingMoviesProtocol {
    var dataStore: DataStoreUpcomingMoviesProtocol? { get }
}

final class UpcomingMoviesRouter: DataPassingUpcomingMoviesProtocol {
    
    // MARK: - Public Variable
    
    weak var view: UpcomingMoviesViewController?
    var dataStore: DataStoreUpcomingMoviesProtocol?
}

// MARK: - ViewToRouter

extension UpcomingMoviesRouter: ViewToRouterUpcomingMoviesProtocol {
    func navigateToEditMovieView() {
        let storyboard = UIStoryboard(name: "EditMovie", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: String(describing: EditMovieViewController.self)) as! EditMovieViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToEditMovie(source: dataStore!, destination: &destinationDS)
        navigateToEditMovie(source: view!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToEditMovie(source: UpcomingMoviesViewController,
                             destination: EditMovieViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Passing Data
    
    func passDataToEditMovie(source: DataStoreUpcomingMoviesProtocol,
                             destination: inout DataStoreEditMovieProtocol) {
        guard let selectedRow = view?.tableView.indexPathForSelectedRow?.row,
              let selectedMovie = source.moviesResponse?.movies?[selectedRow] else { return }
        
        destination.movie = selectedMovie
        destination.tmdbConfig = source.configurationResponse?.tmdbConfig
    }
}
