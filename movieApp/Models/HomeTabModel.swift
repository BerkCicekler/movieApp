//
//  tabModel.swift
//  movieApp
//
//  Created by Berk Çiçekler on 31.12.2024.
//

import Foundation

struct HomeTabModel: Identifiable {
    
    private(set) var id: HomeTab
    private(set) var movies: [MovieModel]
    
    enum HomeTab:String, CaseIterable {
        case nowPlaying = "NowPlaying"
        case upComing = "Up Coming"
        case TopRated = "Top Rated"
        case popular = "Popular"
    }
}
