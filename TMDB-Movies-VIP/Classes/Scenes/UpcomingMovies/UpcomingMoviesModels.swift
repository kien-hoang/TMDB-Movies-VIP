//
//  UpcomingMoviesModels.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//

import Foundation

enum UpcomingMovies {
    
    // MARK: Use cases
    
    enum GetTMDBConfiguration {
        struct Request {}
        struct Response {
            let tmdbConfig: TMDBConfiguration?
            let error: ServiceError?
            
            init(tmdbConfig: TMDBConfiguration? = nil, error: ServiceError? = nil) {
                self.tmdbConfig = tmdbConfig
                self.error = error
            }
        }
        struct ViewModel {}
    }
    
    enum GetMovies {
        struct Request {}
        struct Response {
            let movies: [MovieModel]?
            var error: ServiceError?
            
            init(movies: [MovieModel]? = nil, error: ServiceError? = nil) {
                self.movies = movies
                self.error = error
            }
        }
        struct ViewModel {
            let movies: [UpcomingMovieViewModel]
        }
    }
}

// MARK: - Models

struct UpcomingMovieViewModel {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Float
    let posterUrl: String?
    let backdropUrl: String?
}

struct TMDBConfiguration: Decodable {
    let images: TMDBImageConfiguration
}

struct TMDBImageConfiguration: Decodable {
    let baseURL: String
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
    }
}

struct MovieModel: Decodable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Float
    let posterPath: String
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
