//
//  movieModel.swift
//  movieApp
//
//  Created by Berk Çiçekler on 28.12.2024.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

struct MovieModel: Identifiable, Codable {
    let id: Int
    let title: String
    let genreIds: [Int]?
    let genres: [Genre]?
    let releaseDate: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let runtime: Int?
    
    static func mock() -> MovieModel {
        return MovieModel(id: 939243, title: "mock", genreIds: [], genres: [], releaseDate: "2024", overview: "overview mock", posterPath: "/fwFWhYXj8wY6gFACtecJbg229FI.jpg", backdropPath: "/l5CIAdxVhhaUD3DaS4lP4AR2so9.jpg", runtime: 120)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case genreIds = "genre_ids"
        case genres
        case releaseDate = "release_date"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case runtime
    }
}

extension MovieModel {
    var genreName:String {
        if self.genres != nil {
            return self.genres?.first?.name ?? "Unknown"
        }else if self.genreIds != nil {
            return GenreManager.shared.genres.first {
                return $0.id == self.genreIds!.first
            }?.name ?? "Unknown"
        }else {
            return "Unknown"
        }
    }
}
