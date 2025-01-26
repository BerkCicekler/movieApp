//
//  MovieDetailViewModel.swift
//  movieApp
//
//  Created by Berk Çiçekler on 14.01.2025.
//

import Foundation
import Observation

@Observable
class MovieDetailViewModel {
    let movieId: Int
    var movieData: MovieModel
    var credits: [Credit] = []
    var reviews: [Review] = []
    var isWatchListed: Bool = false
    
    init(movie: MovieModel) {
        self.movieData = movie
        self.movieId = movie.id
        self.isWatchListed = WatchListCache.shared.isExist(movie: movie)
    }
    
    func fetchMovie() async {
        async let movieData = fetchMovieData()
        async let reviews = fetchReviews()
        async let credits = fetchCredits()
        
        _ = await (movieData, reviews, credits)
    }
    
    func toggleWatchList() {
        WatchListCache.shared.toggleMovie(movie: movieData)
        isWatchListed.toggle()
    }
    
    private func fetchMovieData() async {
        let data = await NetworkManager.shared.fetch(path: .movieDetails(id: movieId), method: .get, type: MovieModel.self)
        if let movie = data {
            self.movieData = movie
            
        }
    }
    
    private func fetchCredits() async {
        let data = await NetworkManager.shared.fetch(path: .movieCredits(id: movieId), method: .get, type: CreditsRespnose.self)
        if let credits = data {
            self.credits = credits.cast
        }
    }
    
    private func fetchReviews() async {
        let data = await NetworkManager.shared.fetch(path: .movieReviews(id: movieId), method: .get, type: ReviewResponse.self)
        if let reviewResponse = data {
            self.reviews = reviewResponse.results
        }
    }
    
    
}
