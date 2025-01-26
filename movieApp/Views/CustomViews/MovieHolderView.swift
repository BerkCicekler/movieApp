//
//  MovieHolderView.swift
//  movieApp
//
//  Created by Berk Çiçekler on 26.01.2025.
//

import SwiftUI

struct MovieHolderView: View {
    
    let movie: MovieModel
    
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            HStack(alignment: .top, spacing: 10) {
                customAsyncImage(imagePath: movie.posterPath)
                    .frame(width: posterImageWidth, height: posterImageHeight)
                    .clipShape(.rect(cornerRadius: 10))
                VStack(alignment: .leading, spacing: 7) {
                    Text(movie.title)
                        .font(.title2).bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                    HStack {
                        Image(systemName: "ticket")
                        Text(movie.genreName)
                    }
                    HStack {
                        Image(systemName: "calendar")
                        Text(movie.releaseDate.prefix(4))
                    }
                    HStack {
                        Image(systemName: "star")
                        Text("4.0")
                    }
                }
                .padding(.bottom, 15)
            }.frame(maxWidth: .infinity, maxHeight: posterImageHeight, alignment: .leading)
            .padding(.vertical)
            .foregroundStyle(.white)
        }
    }
    
    var posterImageWidth: CGFloat {
        screenHeight * 0.12
    }
    
    var posterImageHeight: CGFloat {
        screenHeight * 0.185
    }
    
}

#Preview {
    MovieHolderView(movie: MovieModel.mock())
}
