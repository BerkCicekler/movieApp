//
//  credit.swift
//  movieApp
//
//  Created by Berk Çiçekler on 16.01.2025.
//

import Foundation

struct CreditsRespnose: Codable {
    let id: Int
    let cast: [Credit]
}

struct Credit: Codable {
    let id: Int
    let name: String
    let profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}
