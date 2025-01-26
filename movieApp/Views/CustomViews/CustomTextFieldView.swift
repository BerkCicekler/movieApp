//
//  CustomTextField.swift
//  movieApp
//
//  Created by Berk Çiçekler on 26.12.2024.
//

import SwiftUI

struct CustomSearchFieldView: View {
    
    let placeHolderText: String
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            TextField(placeHolderText, text: $text)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(.white)
                        .opacity(text.isEmpty ? 0.0: 1.0)
                        .onTapGesture {
                            text = ""
                        }
                    , alignment: .trailing
                )
                .autocorrectionDisabled()
                
            
        }
            .padding(.vertical, 15)
            .padding(.horizontal, 22)
            .background(Color(hex: 0x3A3F47))
            .clipShape(.rect(cornerRadius: 20))
            .foregroundStyle(.white)
            .font(.system(size: 19))
    }
}

#Preview {
    CustomSearchFieldView(placeHolderText: "", text: .constant(""))
}
