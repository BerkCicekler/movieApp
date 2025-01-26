//
//  GenreManager.swift
//  movieApp
//
//  Created by Berk Çiçekler on 28.12.2024.
//

import Foundation

class GenreManager {
    static let shared = GenreManager()
    private init() {}

    var genres: [Genre] = []

    func fetchGenres(completion: @escaping () -> Void) async {
        let data = await NetworkManager.shared.fetch(path: .genres, method: .get, type: GenreResponse.self)
        if let genres = data?.genres {
            self.genres = genres
        }
        completion()
    }
}

extension GenreManager {
    func findGenreNameFromId(id: Int) -> String {
        if let found = self.genres.first(where: { $0.id == id }) {
            return found.name
        } else {
            return "Unknown"
        }
    }
}
