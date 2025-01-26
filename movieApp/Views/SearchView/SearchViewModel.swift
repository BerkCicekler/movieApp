//
//  searchViewModel.swift
//  movieApp
//
//  Created by Berk Çiçekler on 20.01.2025.
//

import Foundation
import Observation
import SwiftUICore

@Observable
class SearchViewModel {
    var searchText: String = ""
    var movies: [MovieModel] = []
    var totalPages: Int32 = 0
    private(set) var page: Int32 = 0
    
    func onSubmit() async {
        let data = await NetworkManager.shared.fetch(path: .searchMovie, method: .get, type: SearchResponseModel.self, queryParameters: ["query": searchText])
        if let response = data {
            self.movies = response.results
            self.page = response.page
            self.totalPages = response.totalPages
        }
    }
    
    func fetchPage() async {
        let data = await NetworkManager.shared.fetch(path: .searchMovie, method: .get, type: SearchResponseModel.self, queryParameters: ["query": searchText, "page": page])
        if let response = data {
            self.movies = response.results
            self.page = response.page
            self.totalPages = response.totalPages
        }
    }
    
    func changePage(page: Int32) async {
        if page <= 0 || totalPages < page { 
            return
        }
        self.page = page
        await fetchPage()
    }
}
