//
//  movieAppApp.swift
//  movieApp
//
//  Created by Berk Çiçekler on 24.12.2024.
//

import SwiftUI

@main
struct movieApp: App {
    @State private var isInitialized = false

    var body: some Scene {
        WindowGroup {
            if isInitialized {
                NavigationStack {
                    AppTabBarView().preferredColorScheme(.dark)
                }
            } else {
                SplashView()
                    .task {
                        await AppInitialization().initApp()
                        isInitialized = true
                    }
            }
        }
        .environment(\.font, Font.custom(FontContants.Popping.regular, size: 18))
        
    }
}
