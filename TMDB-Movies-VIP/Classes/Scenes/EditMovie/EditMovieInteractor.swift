//
//  EditMovieInteractor.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import Foundation

protocol ViewToInteractorEditMovieProtocol {
    func getMovieData()
    func requestUpdateMovie(_ request: EditMovie.EditMovie.Request)
    
    func canUpdateTitleTextField(_ text: String?,
                                 shouldChangeCharactersIn range: NSRange,
                                 replacementString string: String) -> Bool
    func canUpdateOverviewTextField(_ text: String?,
                                    shouldChangeCharactersIn range: NSRange,
                                    replacementString string: String) -> Bool
}

protocol DataStoreEditMovieProtocol {
    var movie: MovieModel! { get set }
    var tmdbConfig: TMDBConfiguration? { get set }
}

final class EditMovieInteractor: DataStoreEditMovieProtocol {
    
    struct Constant {
        static let titleMaxLength = 50
        static let overviewMaxLength = 200
        static let pointMin = 0.0
        static let pointMax = 10.0
    }
    
    // MARK: - Public Variable
    
    var presenter: InteractorToPresenterEditMovieProtocol?
    var worker: InteractorToWorkerEditMovieProtocol?
    var movie: MovieModel!
    var tmdbConfig: TMDBConfiguration?
}

// MARK: - ViewToInteractor

extension EditMovieInteractor: ViewToInteractorEditMovieProtocol {
    func requestUpdateMovie(_ request: EditMovie.EditMovie.Request) {
        guard isValidMovie(with: request) else { return }
        
        movie.title = request.title
        movie.overview = request.overview
        movie.voteAverage = Float(request.pointAverage) ?? 0
        
        presenter?.updateMovieDataSuccess()
    }
    
    func canUpdateTitleTextField(_ text: String?,
                                 shouldChangeCharactersIn range: NSRange,
                                 replacementString string: String) -> Bool {
        let count = getTextCount(text,
                                 shouldChangeCharactersIn: range,
                                 replacementString: string)
        return count <= Constant.titleMaxLength
    }
    
    func canUpdateOverviewTextField(_ text: String?,
                                    shouldChangeCharactersIn range: NSRange,
                                    replacementString string: String) -> Bool {
        let count = getTextCount(text,
                                 shouldChangeCharactersIn: range,
                                 replacementString: string)
        return count <= Constant.overviewMaxLength
    }
    
    func getMovieData() {
        presenter?.showMovieData(with: movie, config: tmdbConfig)
    }
}

// MARK: - Private

private extension EditMovieInteractor {
    func isValidMovie(with request: EditMovie.EditMovie.Request) -> Bool {
        let title = request.title.asTrimmed
        let overview = request.overview.asTrimmed
        let pointAverage = request.pointAverage.asTrimmed
        
        let isValidTitle = isValidTitle(title)
        let isValidOverview = isValidOverview(overview)
        let isValidPoint = isValidPoint(pointAverage)
        
        return isValidTitle && isValidOverview && isValidPoint
    }
    
    func isValidTitle(_ title: String) -> Bool {
        if title.isEmpty {
            presenter?.showMovieTitleError("Title can not empty!")
            return false
        } else {
            presenter?.showMovieTitleError(nil)
            return true
        }
    }
    
    func isValidOverview(_ overview: String) -> Bool {
        if overview.isEmpty {
            presenter?.showMovieOverviewError("Overview can not empty!")
            return false
        } else {
            presenter?.showMovieOverviewError(nil)
            return true
        }
    }
    
    func isValidPoint(_ point: String) -> Bool {
        guard let safePoint = Float(point) else {
            presenter?.showMoviePointAverageError("Point must be a number!")
            return false
        }
        
        let isValidPoint = 0...10 ~= safePoint
        
        if !isValidPoint {
            presenter?.showMoviePointAverageError("Point must be between 0.0 and 10.0!")
            return false
        } else {
            presenter?.showMoviePointAverageError(nil)
            return true
        }
    }
    
    func getTextCount(_ text: String?,
                      shouldChangeCharactersIn range: NSRange,
                      replacementString string: String) -> Int {
        guard let safeText = text,
              let rangeOfTextToReplace = Range(range, in: safeText) else {
            return 0
        }
        let substringToReplace = safeText[rangeOfTextToReplace]
        let count = safeText.count - substringToReplace.count + string.count
        return count
    }
}
