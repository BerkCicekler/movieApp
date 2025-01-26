//
//  WatchListCache.swift
//  movieApp
//
//  Created by Berk Çiçekler on 24.01.2025.
//

import Foundation

class WatchListCache {
    
    static let shared = WatchListCache()
    
    init() {
        loadMoviesFromFile()
    }
    
    private(set) var movies: [MovieModel] = []
    
    private let fileName = "watchList.json"
    
    /// if the movie is already in the watchList remove it and save
    /// if its not add it and save
    func toggleMovie(movie: MovieModel) {
        if isExist(movie: movie) {
            removeFromWatchList(movie: movie)
        }else {
            addToWatchList(movie: movie)
        }
        saveMoviesToFile()
    }
    
    func isExist(movie: MovieModel) -> Bool {
        return movies.contains {
            return $0.id == movie.id
        }
    }
    
    func addToWatchList(movie: MovieModel) {
        if isExist(movie: movie) {
            return
        }
        movies.append(movie)
    }
    
    func removeFromWatchList(movie: MovieModel) {
        movies.removeAll(where: {
            return $0.id == movie.id
        })
    }
    
    private func saveMoviesToFile() {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentsURL = urls.first else { return }

        let fileURL = documentsURL.appendingPathComponent(fileName)
        do {
            let data = try JSONEncoder().encode(movies)
            try data.write(to: fileURL)
            debugPrint("Movies Saved: \(fileURL.path)")
        } catch {
            debugPrint("There was an error while saving the movies: \(error.localizedDescription)")
        }
    }
    
    private func loadMoviesFromFile() {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentsURL = urls.first else {
            print("Cannot read the Struct")
            return
        }

        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        // Create file if not exist
        if !fileManager.fileExists(atPath: fileURL.path()) {
            let emptyJSONData = "[]".data(using: .utf8)
            let file = fileManager.createFile(atPath: fileURL.path(), contents: emptyJSONData)
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            movies = try JSONDecoder().decode([MovieModel].self, from: data)
        } catch {
            print("There was an error while reading the struct: \(error.localizedDescription)")
        }
    }
    
}
