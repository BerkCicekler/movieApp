//
//  customAsyncImage.swift
//  movieApp
//
//  Created by Berk Çiçekler on 29.12.2024.
//

import SwiftUI
import CachedAsyncImage

struct customAsyncImage: View {
    let imagePath: String?
    var isCached: Bool = true
    var body: some View {
        if imagePath == nil {
            Text("No Image")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray)
        }else if isCached {
            CachedAsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(imagePath!)")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Image(systemName: "photo")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray)
                }
            }
        }else {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(imagePath!)")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Image(systemName: "photo")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray)
                }
            }
        }

    }
}

#Preview {
    customAsyncImage(
         imagePath: nil,
         isCached: false
    )
}
