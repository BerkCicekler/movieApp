//
//  ContentView.swift
//  movieApp
//
//  Created by Berk Çiçekler on 24.12.2024.
//

import SwiftUI  

struct HomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                    Text("What do you want to watch?")
                    .font(.custom(FontContants.Popping.semiBold, size: 21))
                    .foregroundStyle(.white)
                HorizantalMovieScroll(movies: viewModel.nowPlaying)
                
                HomeTabView()
                                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 22)
        .background(AppColorConstants.BackgroundColor)
        .environment(viewModel)
        .task {
            async let task1: () = viewModel.fetchPopular()
            async let task2: () = viewModel.fetchUpComing()
            async let task3: () = viewModel.fetchTopRated()
            async let task4: () = viewModel.fetchNowPlaying()
            _ = await (task1, task2, task3, task4)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}

fileprivate struct HorizantalMovieScroll: View {
    
    let movies: [MovieModel]
    
    @State private var goToMovie: MovieModel? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 30) {
                ForEach(movies, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        customAsyncImage(imagePath: movie.posterPath)
                            .frame(width: 150, height: 210)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
            }
        }
        .frame(maxHeight: 210)
    }
}



fileprivate struct HomeTabView: View {
    
    @Environment(HomeViewModel.self) private var homeViewModel
    
    @State private var tabs: [HomeTabModel] = []
    
    @State private var currentListedMovies : [MovieModel] = []
    
    @State private var activeTab: HomeTabModel.HomeTab = .TopRated
    @State private var mainViewScrollState: HomeTabModel.HomeTab? = .TopRated
    @State private var tabBarScrollState: HomeTabModel.HomeTab? = .TopRated
    
    
    var body: some View {
        CustomTabBar()
        ScrollView(showsIndicators: false) {
            if let movies = tabs.first(where: { $0.id == activeTab })?.movies {
                MoviesGridView(movies: movies)
            }
        }
        .onAppear() {
            Task {
                await waitUntilMoviesFetch()

                tabs = [
                    .init(id: HomeTabModel.HomeTab.TopRated, movies: homeViewModel.topRated),
                    .init(id: HomeTabModel.HomeTab.nowPlaying, movies: homeViewModel.nowPlaying),
                    .init(id: HomeTabModel.HomeTab.popular, movies: homeViewModel.popular),
                    .init(id: HomeTabModel.HomeTab.upComing, movies: homeViewModel.upComing)
                ]
            }
        }
    }
    
    private func waitUntilMoviesFetch() async {
        while homeViewModel.topRated.isEmpty ||
              homeViewModel.nowPlaying.isEmpty ||
              homeViewModel.popular.isEmpty ||
              homeViewModel.upComing.isEmpty {
            try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 wait till movies load
        }
    }
    
    func onTabButtonPress(tab: HomeTabModel) {
        withAnimation(.snappy) {
            activeTab = tab.id
            tabBarScrollState = tab.id
            mainViewScrollState = tab.id
        }
    }
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(tabs) { tab in
                    Button(action: {
                        onTabButtonPress(tab: tab)
                    }) {
                        Text(tab.id.rawValue)
                            .padding(.vertical, 12)
                            .foregroundStyle(.white)
                            .fontWeight(tab.id == activeTab ? .bold : .regular)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollPosition(id: .init(get: {
            return tabBarScrollState
        }, set: { _ in
        }), anchor: .center)
    }
    
    @ViewBuilder
    func MoviesGridView(movies: [MovieModel]) -> some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 3)
        LazyVGrid(columns: columns) {
            ForEach(movies, id: \.id) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    customAsyncImage(imagePath: movie.posterPath)
                        .aspectRatio(1, contentMode: .fit)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 15))
                    
                }
            }
        }
    }
    
}
