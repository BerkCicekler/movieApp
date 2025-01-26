//
//  SearchResponseModel.swift
//  movieApp
//
//  Created by Berk Çiçekler on 21.01.2025.
//

import Foundation

struct SearchResponseModel: Codable {
    let page: Int32
    let results: [MovieModel]
    let totalPages: Int32
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
