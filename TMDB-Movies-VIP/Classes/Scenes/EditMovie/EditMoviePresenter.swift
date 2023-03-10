//
//  EditMoviePresenter.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import Foundation

protocol InteractorToPresenterEditMovieProtocol {
    func showMovieData(with movie: MovieModel, config: TMDBConfiguration?)
    func updateMovieDataSuccess()
    
    func showMovieTitleError(_ error: String?)
    func showMovieOverviewError(_ error: String?)
    func showMoviePointAverageError(_ error: String?)
}

final class EditMoviePresenter {
    
    // MARK: - Public Variable
    
    weak var view: PresenterToViewEditMovieProtocol?
}

// MARK: - InteractorToPresenter

extension EditMoviePresenter: InteractorToPresenterEditMovieProtocol {
    func updateMovieDataSuccess() {
        view?.updateMovieDataSuccess()
    }
    
    func showMovieTitleError(_ error: String?) {
        view?.showMovieTitleError(error)
    }
    
    func showMovieOverviewError(_ error: String?) {
        view?.showMovieOverviewError(error)
    }
    
    func showMoviePointAverageError(_ error: String?) {
        view?.showMoviePointAverageError(error)
    }
    
    func showMovieData(with movie: MovieModel, config: TMDBConfiguration?) {
        let baseImageUrl = config?.images.baseURL
        let size = "w300" // Hardcode temporarily
        var posterImageUrl: String? = nil
        if baseImageUrl != nil && movie.posterPath != nil {
            posterImageUrl = baseImageUrl! + size + movie.posterPath!
        }
        var backdropImageUrl: String? = nil
        if baseImageUrl != nil && movie.backdropPath != nil {
            backdropImageUrl = baseImageUrl! + size + movie.backdropPath!
        }
        
        let viewModel = EditMovie.EditMovie.ViewModel(id: "\(movie.id)",
                                                      title: movie.title,
                                                      overview: movie.overview,
                                                      pointAverage: "\(movie.voteAverage)",
                                                      posterImageUrl: posterImageUrl,
                                                      backdropImageUrl: backdropImageUrl)
        view?.updateUI(with: viewModel)
    }
}
