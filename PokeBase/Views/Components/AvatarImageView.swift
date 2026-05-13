//
//  AvatarImageView.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 13/05/26.
//

import SwiftUI

struct AvatarImageView: View {
    let url: URL
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size, height: size)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundStyle(.secondary)
            @unknown default:
                EmptyView()
            }
        }
        .background(.tertiary)
        .clipShape(Circle())
    }
}

#Preview {
    AvatarImageView(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png")!, size: 120)
}
