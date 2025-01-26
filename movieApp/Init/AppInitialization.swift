//
//  app_initalization.swift
//  movieApp
//
//  Created by Berk Çiçekler on 28.12.2024.
//

import Foundation

class AppInitialization {
    
    func initApp() async {
        await GenreManager.shared.fetchGenres {
            debugPrint("Genres fetched")
        }
    }
}
