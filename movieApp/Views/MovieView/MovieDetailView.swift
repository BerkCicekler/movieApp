//
//  movieView.swift
//  movieApp
//
//  Created by Berk Çiçekler on 13.01.2025.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: MovieDetailViewModel
    
    init(movie: MovieModel) {
        viewModel = MovieDetailViewModel(movie: movie)
    }
    
    var body: some View {
        ScrollView {
            VStack() {
                ImagesAndTitle()
                someInfo()
                    .padding(.top, posterImageHeight * 0.55)
                TabView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 15)
        .background(AppColorConstants.BackgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                }
                
            }
            ToolbarItem(placement: .principal) {
                Text("Detail")
                    .foregroundColor(.white)
                    .font(.custom(FontContants.Popping.medium, size: 22))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: viewModel.isWatchListed ?  "bookmark.fill" : "bookmark" )
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 18, height: 24)
                    .onTapGesture(perform: viewModel.toggleWatchList)
            }
        }
        .toolbarBackground(AppColorConstants.BackgroundColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .environment(viewModel)
        .task {
            await viewModel.fetchMovie()
        }
    }
    
    @ViewBuilder
    func ImagesAndTitle() -> some View {
        ZStack {
            customAsyncImage(imagePath: viewModel.movieData.backdropPath)
                .frame(height: backgroundImageHeight)
            HStack() {
                customAsyncImage(imagePath: viewModel.movieData.posterPath)
                    .frame(width: posterImageHeight * 0.7, height: posterImageHeight)
                    .clipShape(.rect(cornerRadius: 5))
                
                Text(viewModel.movieData.title)
                        .foregroundStyle(.white)
                        .font(.custom(FontContants.Popping.semiBold, size: 21))
                        .offset(y: 25)
            }.offset(y: backgroundImageHeight * 0.55)
                .frame(width: screenWidth * 0.85, alignment: .leading)
        }
    }
    
    @ViewBuilder
    func someInfo() -> some View {
        HStack {
            Image(systemName: "calendar")
            Text(String(viewModel.movieData.releaseDate.prefix(4)))
            Rectangle()
                .frame(width: 1)
            Image(systemName: "clock")
            Text(String(viewModel.movieData.runtime ?? 0))
            Rectangle()
                .frame(width: 1)
            if let genres = viewModel.movieData.genres, !genres.isEmpty {
                Image(systemName: "ticket")
                Text(genres[0].name)
            } else {
                Text("Genre not available")
            }
        }
        .foregroundStyle(.gray)
    }
    
    var posterImageHeight: CGFloat {
        screenHeight * 0.2
    }
    
    var backgroundImageHeight: CGFloat {
        screenHeight * 0.25
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: MovieModel.mock())
    }
}


fileprivate struct TabView: View {
    
    let tabs: [MovieDetailTabModel] = [
        .init(id: .about, view: { AnyView(aboutMovieView()) }),
        .init(id: .reviews, view: { AnyView(ReviewsView()) }),
        .init(id: .cast, view: { AnyView(CastView())})
    ]
    @State private var currentTab: Int = 0
    
    var body: some View {
        VStack {
              ScrollView(.horizontal, showsIndicators: false) {
                  HStack(spacing: 20) {
                      ForEach(Array(tabs.enumerated()), id: \.0) { index, tab in
                          TabButton(
                              title: tab.id.rawValue,
                              isSelected: index == currentTab
                          ) {
                              currentTab = index
                          }
                      }
                      
                  }
                  .frame(minWidth: screenWidth, alignment: .center)
              }
              .padding(.vertical, 10)
              tabs[currentTab].view()
                .padding(.horizontal)
          }
      }
}

fileprivate struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.vertical, 12)
                .foregroundStyle(.white)
                .fontWeight(isSelected ? .bold : .regular)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct aboutMovieView: View {
    @Environment(MovieDetailViewModel.self) private var viewModel
    
    var body: some View {
        Text(viewModel.movieData.overview)
            .foregroundStyle(.white)
    }
}

fileprivate struct CastView: View {
    @Environment(MovieDetailViewModel.self) private var viewModel
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 2)
        LazyVGrid(columns: columns) {
            ForEach(viewModel.credits, id: \.id) { credit in
                GridViewElement(credit: credit)
            }
            
        }
    }
    
    @ViewBuilder
    private func GridViewElement(credit: Credit) -> some View {
        VStack(spacing: 0) {
            customAsyncImage(imagePath: credit.profilePath ?? "")
                .aspectRatio(1, contentMode: .fit)
                .frame(width: screenWidth / 3)
                .clipped()
                .clipShape(Circle())
            Text(credit.name)
                .foregroundStyle(.white)
                .lineLimit(1)

            
        }.frame(maxHeight: 200, alignment: .top)
    }
}

fileprivate struct ReviewsView: View {
    
    @Environment(MovieDetailViewModel.self) private var viewModel
    
    var body: some View {
        if viewModel.reviews.isEmpty {
            Text("No Reviews").foregroundStyle(.white)
        }else {
            VStack {
                ForEach(viewModel.reviews, id:\.id) { review in
                    Review(review: review)
                }
            }
        }
    }
    
    @ViewBuilder
    private func Review(review: Review) -> some  View {
        HStack(alignment: .top, spacing: 15) {
                customAsyncImage(imagePath: "/yz2HPme8NPLne0mM8tBnZ5ZWJzf.jpg", isCached: false)
                .frame(width: 55, height: 55)
                .clipShape(.circle)
            
            VStack(alignment: .leading) {
                Text(review.author).bold()
                Text(review.content)
                    .lineLimit(4)
            }.foregroundStyle(.white)
        }
    }
}
