//
//  fontConstants.swift
//  movieApp
//
//  Created by Berk Çiçekler on 27.12.2024.
//

import Foundation

enum FontContants: String, CaseIterable {
    case Popping = "Poppins";
    
}

extension FontContants {
    var regular: String {
        return self.rawValue + "-Regular"
    }
    
    var semiBold: String {
        return self.rawValue + "-SemiBold"
    }
    
    var medium: String {
        return self.rawValue + "-Medium"
    }
}
