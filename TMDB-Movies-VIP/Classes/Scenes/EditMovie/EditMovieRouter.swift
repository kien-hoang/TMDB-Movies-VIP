//
//  EditMovieRouter.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import UIKit

protocol ViewToRouterEditMovieProtocol: AnyObject {
    func navigateBackToUpcomingMovies()
}

protocol DataPassingEditMovieProtocol {
    var dataStore: DataStoreEditMovieProtocol? { get }
}

final class EditMovieRouter: DataPassingEditMovieProtocol {
    
    // MARK: - Public Variable
    
    weak var view: EditMovieViewController?
    var dataStore: DataStoreEditMovieProtocol?
}

// MARK: - ViewToRouter

extension EditMovieRouter: ViewToRouterEditMovieProtocol {
    func navigateBackToUpcomingMovies() {
        guard let destinationVC = view?.navigationController?.viewControllers.first(where: { $0 is UpcomingMoviesViewController }) as? UpcomingMoviesViewController else { return }
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSomeWhere(source: dataStore!, destination: &destinationDS)
        destinationVC.updateMovieSuccess()
        navigateToSomeWhere(source: view!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToSomeWhere(source: EditMovieViewController,
                             destination: UpcomingMoviesViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Passing data
    
    func passDataToSomeWhere(source: DataStoreEditMovieProtocol,
                             destination: inout DataStoreUpcomingMoviesProtocol) {
        guard let firstIndex = destination.moviesResponse?.movies?.firstIndex(where: { $0.id == source.movie.id }) else { return }
        destination.moviesResponse?.movies?[firstIndex] = source.movie
    }
}
