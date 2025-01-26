//
//  movieDetailTabModel.swift
//  movieApp
//
//  Created by Berk Çiçekler on 14.01.2025.
//

import Foundation
import SwiftUICore

struct MovieDetailTabModel: Identifiable {
    let id: DetailTabEnum
    let view: () -> AnyView
    
    enum DetailTabEnum:String, CaseIterable {
        case about = "About Movie"
        case reviews = "Reviews"
        case cast = "Cast"
    }
}
