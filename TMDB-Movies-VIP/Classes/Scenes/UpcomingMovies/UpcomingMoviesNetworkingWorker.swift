//
//  UpcomingMoviesNetworkWorker.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 02/01/2023.
//

import Foundation

protocol InteractorToNetworkWorkerUpcomingMoviesProtocol {
    func getAPIConfiguration(completion: @escaping (Result<TMDBConfiguration, ServiceError>) -> Void)
    func getListErrorProducts(completion: @escaping (Result<[MovieModel], ServiceError>) -> Void)
}

final class UpcomingMoviesNetworkingWorker: BaseNetworking, InteractorToNetworkWorkerUpcomingMoviesProtocol {
    
    func getAPIConfiguration(completion: @escaping (Result<TMDBConfiguration, ServiceError>) -> Void) {
        fetchData(configuration: TMDBNetworkingConfiguration.getAPIConfiguration,
                  responseType: TMDBConfiguration.self) { result in
            switch result {
            case .success(let configuration):
                completion(.success(configuration))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getListErrorProducts(completion: @escaping (Result<[MovieModel], ServiceError>) -> Void) {
        fetchData(configuration: MovieNetworkingConfiguration.getUpcomingMovies,
                  responseType: DefaultResponse<[MovieModel]>.self) { result in
            switch result {
            case .success(let defaultResponse):
                completion(.success(defaultResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
