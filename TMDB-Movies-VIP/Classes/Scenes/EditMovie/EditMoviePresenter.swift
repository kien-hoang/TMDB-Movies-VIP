//
//  EditMoviePresenter.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import Foundation

protocol InteractorToPresenterEditMovieProtocol {}

final class EditMoviePresenter {
    
    // MARK: - Public Variable
    
    weak var view: PresenterToViewEditMovieProtocol?
}

// MARK: - InteractorToPresenter

extension EditMoviePresenter: InteractorToPresenterEditMovieProtocol {}

// MARK: - Private

private extension EditMoviePresenter {}
