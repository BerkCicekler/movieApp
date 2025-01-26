//
//  HomeViewModel.swift
//  movieApp
//
//  Created by Berk Çiçekler on 28.12.2024.
//

import Foundation
import Observation

@Observable
class HomeViewModel {
    var nowPlaying: [MovieModel] = []
    var upComing: [MovieModel] = []
    var topRated: [MovieModel] = []
    var popular: [MovieModel] = []
    
    func fetchNowPlaying() async {
        let data = await NetworkManager.shared.fetch(path: .nowPlaying, method: .get, type: MovieResponse.self)
        if let movies = data?.results {
            self.nowPlaying = movies
            
        }
    }
    
    func fetchUpComing() async {
        let data = await NetworkManager.shared.fetch(path: .upComing, method: .get, type: MovieResponse.self)
        if let movies = data?.results {
            self.upComing = movies
            
        }
    }
    
    func fetchTopRated() async {
        let data = await NetworkManager.shared.fetch(path: .topRated, method: .get, type: MovieResponse.self)
        if let movies = data?.results {
            self.topRated = movies
            
        }
    }
    
    func fetchPopular() async {
        let data = await NetworkManager.shared.fetch(path: .popular, method: .get, type: MovieResponse.self)
        if let movies = data?.results {
            self.popular = movies
            
        }
    }
}
