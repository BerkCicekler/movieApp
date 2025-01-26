//
//  genreModel.swift
//  movieApp
//
//  Created by Berk Çiçekler on 28.12.2024.
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Hashable {
    let id: Int
    let name: String
}
