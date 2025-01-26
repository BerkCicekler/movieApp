//
//  SplashView.swift
//  movieApp
//
//  Created by Berk Çiçekler on 23.01.2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(alignment: .center) {
            ProgressView().tint(.white)
        }
        .foregroundStyle(.white)
            .font(.title2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColorConstants.BackgroundColor)
    }
}

#Preview {
    SplashView()
}
