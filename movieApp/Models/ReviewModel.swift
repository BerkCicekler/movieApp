//
//  reviewModel.swift
//  movieApp
//
//  Created by Berk Çiçekler on 20.01.2025.
//

import Foundation

struct ReviewResponse: Codable {
    let results: [Review]
}

struct Review: Codable, Identifiable {
    let id: String
    let author: String
    let content: String
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case author
        case content
        case createdAt = "created_at"
    }
}
