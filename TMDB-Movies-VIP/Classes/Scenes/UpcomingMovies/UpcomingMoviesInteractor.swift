//
//  UpcomingMoviesInteractor.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 02/01/2023.
//

import Foundation

protocol ViewToInteractorUpcomingMoviesProtocol {
    func viewDidLoad()
    func reloadTableViewData()
}

protocol DataStoreUpcomingMoviesProtocol {
    var moviesResponse: UpcomingMovies.GetMovies.Response? { get set }
    var configurationResponse: UpcomingMovies.GetTMDBConfiguration.Response? { get set }
}

final class UpcomingMoviesInteractor: DataStoreUpcomingMoviesProtocol {
    
    // MARK: - Public Variable
    
    var presenter: InteractorToPresenterUpcomingMoviesProtocol?
    var networkWorker: InteractorToNetworkWorkerUpcomingMoviesProtocol?
    var moviesResponse: UpcomingMovies.GetMovies.Response?
    var configurationResponse: UpcomingMovies.GetTMDBConfiguration.Response?
    
    // MARK: - Private Variable
    
    private let waitingToStartGroup = DispatchGroup()
}

// MARK: - ViewToInteractor

extension UpcomingMoviesInteractor: ViewToInteractorUpcomingMoviesProtocol {
    func reloadTableViewData() {
        guard let movies = moviesResponse,
              let configuration = configurationResponse else { return }
        
        presenter?.showUpcomingMovies(with: movies,
                                      configuration: configuration)
    }
    
    func viewDidLoad() {
        presenter?.showLoading()
        getTMDBConfiguration()
        getUpcomingMovies()
        
        waitingToStartGroup.notify(queue: .main) { [weak self] in
            self?.presenter?.hideLoading()
            guard let self = self,
                  let movies = self.moviesResponse,
                  let configuration = self.configurationResponse else { return }
            
            if let error = self.handleError(of: movies, and: configuration) {
                self.presenter?.showError(error)
            }
            
            self.presenter?.showUpcomingMovies(with: movies,
                                               configuration: configuration)
        }
    }
}

// MARK: - Private

private extension UpcomingMoviesInteractor {
    func handleError(of moviesResponse: UpcomingMovies.GetMovies.Response,
                     and configurationResponse: UpcomingMovies.GetTMDBConfiguration.Response) -> ServiceError? {
        if let error = moviesResponse.error {
            return error
        }
        if let error = configurationResponse.error {
            return error
        }
        return nil
    }
    
    func getTMDBConfiguration() {
        waitingToStartGroup.enter()
        networkWorker?.getAPIConfiguration { [weak self] result in
            defer { self?.waitingToStartGroup.leave() }
            switch result {
            case .success(let config):
                self?.configurationResponse = UpcomingMovies.GetTMDBConfiguration.Response(tmdbConfig: config)
            case .failure(let error):
                self?.configurationResponse = UpcomingMovies.GetTMDBConfiguration.Response(error: error)
            }
        }
    }
    
    func getUpcomingMovies() {
        waitingToStartGroup.enter()
        networkWorker?.getListErrorProducts { [weak self] result in
            defer { self?.waitingToStartGroup.leave() }
            switch result {
            case .success(let movies):
                self?.moviesResponse = UpcomingMovies.GetMovies.Response(movies: movies)
            case .failure(let error):
                self?.moviesResponse = UpcomingMovies.GetMovies.Response(error: error)
            }
        }
    }
}
