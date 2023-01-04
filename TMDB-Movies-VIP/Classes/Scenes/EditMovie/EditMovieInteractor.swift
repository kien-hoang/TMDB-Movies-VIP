//
//  EditMovieInteractor.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import Foundation

protocol ViewToInteractorEditMovieProtocol {
    func setupMovieData()
}

protocol DataStoreEditMovieProtocol {
    var movie: MovieModel! { get set }
    var tmdbConfig: TMDBConfiguration? { get set }
}

final class EditMovieInteractor: DataStoreEditMovieProtocol {
    
    // MARK: - Public Variable
    
    var presenter: InteractorToPresenterEditMovieProtocol?
    var worker: InteractorToWorkerEditMovieProtocol?
    var movie: MovieModel!
    var tmdbConfig: TMDBConfiguration?
    
    // MARK: - Private Variable
    
}

// MARK: - ViewToInteractor

extension EditMovieInteractor: ViewToInteractorEditMovieProtocol {
    func setupMovieData() {
        print("DEBUG: \(movie.title)")
        print("DEBUG: \(tmdbConfig?.images.baseURL)")
    }
}

// MARK: - Private

private extension EditMovieInteractor {}
