//
//  WatchListVİew.swift
//  movieApp
//
//  Created by Berk Çiçekler on 26.01.2025.
//

import SwiftUI

struct WatchListView: View {
    
    @State var movies: [MovieModel] = []
    
    private func onAppear() {
        movies = WatchListCache.shared.movies
    }
    
    var body: some View {
        VStack() {
            ForEach(movies) {
                MovieHolderView(movie: $0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(22)
            .background(AppColorConstants.BackgroundColor)
            .onAppear(perform: onAppear)
    }
}

#Preview {
    WatchListView()
}
