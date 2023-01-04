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
}

final class EditMoviePresenter {
    
    // MARK: - Public Variable
    
    weak var view: PresenterToViewEditMovieProtocol?
}

// MARK: - InteractorToPresenter

extension EditMoviePresenter: InteractorToPresenterEditMovieProtocol {
    func showMovieData(with movie: MovieModel, config: TMDBConfiguration?) {
        let baseImageUrl = config?.images.baseURL
        let size = "w300" // Hardcode temporarily
        let posterImageUrl = baseImageUrl != nil ? baseImageUrl! + size + movie.posterPath : nil
        let backdropImageUrl = baseImageUrl != nil ? baseImageUrl! + size + movie.backdropPath : nil
        
        let viewModel = EditMovie.EditMovie.ViewModel(id: "\(movie.id)",
                                                      title: movie.title,
                                                      overview: movie.overview,
                                                      pointAverage: "\(movie.voteAverage)",
                                                      posterImageUrl: posterImageUrl,
                                                      backdropImageUrl: backdropImageUrl)
        view?.updateUI(with: viewModel)
    }
}

// MARK: - Private

private extension EditMoviePresenter {}
