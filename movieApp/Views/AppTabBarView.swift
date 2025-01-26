//
//  AppTabBarView.swift
//  movieApp
//
//  Created by Berk Çiçekler on 27.12.2024.
//

import SwiftUI
import SVGKit

struct AppTabBarView: View {
    @State private var selectedItem = 0
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(AppColorConstants.BackgroundColor)

        UITabBar.appearance().standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private let tabItems: [TabItemModel] = [
        .init(view: HomeView(), text: "Home", image: "home"),
        .init(view: SearchView(), text: "Search", image: "search"),
        .init(view: WatchListView(), text: "Embed", image: "bookmark"),
    ]
    
    
    
    var body: some View {
        TabView(selection: $selectedItem) {
            ForEach(tabItems.indices, id: \.self) { index in
                let item = tabItems[index]
                item.view
                    .tabItem {
                        Image(item.image).renderingMode(.template)
                        Text(item.text)
                    }
            }
        }
    }
}

struct TabItemModel {
    let view: AnyView
    let text: String
    let image: String
    
    init<Content: View>(view: Content, text: String, image: String) {
        self.view = AnyView(view)
        self.text = text
        self.image = image
    }
}

#Preview {
    AppTabBarView()
}
