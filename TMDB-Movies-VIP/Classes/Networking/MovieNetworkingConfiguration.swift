//
//  MovieNetworkingConfiguration.swift
//
//
//  Created by Bradley Hoang on 28/12/2022.
//

import Foundation

enum MovieNetworkingConfiguration {
    case getUpcomingMovies
}

extension MovieNetworkingConfiguration: Configuration {
    var baseURL: String { return NetworkingConstant.baseUrl }
    
    var path: String {
        switch self {
        case .getUpcomingMovies:
            return "3/movie/upcoming"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUpcomingMovies:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUpcomingMovies:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(NetworkingConstant.accessToken)"]
        }
    }
    
    var data: Data? {
        return nil
    }
}
