//
//  UpcomingMoviesPresenter.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 02/01/2023.
//

import Foundation

protocol InteractorToPresenterUpcomingMoviesProtocol {
    func showUpcomingMovies(with moviesResponse: UpcomingMovies.GetMovies.Response,
                            configuration: UpcomingMovies.GetTMDBConfiguration.Response)
    func showLoading()
    func hideLoading()
    func showError(_ error: ServiceError)
}

final class UpcomingMoviesPresenter {
    
    // MARK: - Public Variable
    
    weak var view: PresenterToViewUpcomingMoviesProtocol?
}

// MARK: - InteractorToPresenter

extension UpcomingMoviesPresenter: InteractorToPresenterUpcomingMoviesProtocol {
    func showUpcomingMovies(with moviesResponse: UpcomingMovies.GetMovies.Response,
                            configuration: UpcomingMovies.GetTMDBConfiguration.Response) {
        let viewModels = buildViewModels(with: moviesResponse, configuration: configuration)
        view?.reloadTableViewData(with: UpcomingMovies.GetMovies.ViewModel(movies: viewModels))
    }
    
    func showLoading() {
        view?.showLoading()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
    
    func showError(_ error: ServiceError) {
        view?.showError(error)
    }
}

// MARK: - Private

private extension UpcomingMoviesPresenter {
    func buildViewModels(with moviesResponse: UpcomingMovies.GetMovies.Response,
                         configuration: UpcomingMovies.GetTMDBConfiguration.Response) -> [UpcomingMovieViewModel] {
        guard let movies = moviesResponse.movies else { return [] }
        
        let baseImageUrl = configuration.tmdbConfig?.images.baseURL
        let size = "w300" // Hardcode temporarily
        
        let viewModels = movies.map {
            let posterImageUrl = baseImageUrl != nil ? baseImageUrl! + size + $0.posterPath : nil
            let backdropImageUrl = baseImageUrl != nil ? baseImageUrl! + size + $0.backdropPath : nil
            
            return UpcomingMovieViewModel(id: $0.id,
                                          title: $0.title,
                                          overview: $0.overview,
                                          voteAverage: $0.voteAverage,
                                          posterUrl: posterImageUrl,
                                          backdropUrl: backdropImageUrl)
        }
        
        return viewModels
    }
}
