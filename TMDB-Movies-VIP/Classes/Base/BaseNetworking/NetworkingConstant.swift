//
//  NetworkingConstant.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 01/01/2023.
//

import Foundation

struct NetworkingConstant {
    static let baseUrl = "https://api.themoviedb.org/"
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3Y2RlYjI3NWQwODI1OWI4MTdhM2I4MGE3ZmY4NWYxNSIsInN1YiI6IjYzYjExYTM0N2VmMzgxMWY2YzE2Y2ExNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SrOUTAkqvCtvv5XIPNz7TZerG6hn2LDtWgqu4jPr6oI"
}

typealias DefaultResponse<R: Decodable> = TMDBMoviesDefaultResponseModel<R>

struct TMDBMoviesDefaultResponseModel<R: Decodable>: Decodable {
    let page: Int
    let results: R
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
