//
//  EditMovieModels.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import Foundation

enum EditMovie {
    
    // MARK: Use cases
    
    enum EditMovie {
        struct Request {
            let title: String
            let overview: String
            let pointAverage: String
        }
        struct Response {
        }
        struct ViewModel {
            let id: String
            let title: String
            let overview: String
            let pointAverage: String
            let posterImageUrl: String?
            let backdropImageUrl: String?
        }
    }
}
