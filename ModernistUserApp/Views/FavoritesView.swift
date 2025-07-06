//
//  FavoritesView.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 1.07.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.favoriteUsers.isEmpty {
                VStack {
                    Spacer()
                    Image(systemName: "heart.slash")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    Text("Henüz favori kullanıcınız yok")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("Kullanıcılar sekmesinden favori ekleyebilirsiniz")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
                .navigationTitle("Favoriler")
                .navigationBarTitleDisplayMode(.large)
            } else {
                List {
                    ForEach(viewModel.favoriteUsers) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            UserRowView(
                                user: user,
                                isFavorite: true,
                                onFavoriteToggle: {
                                    viewModel.removeFromFavorites(user)
                                }
                            )
                        }
                    }
                    .onDelete(perform: deleteUsers)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Favoriler")
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
    
    private func deleteUsers(offsets: IndexSet) {
        for index in offsets {
            let user = viewModel.favoriteUsers[index]
            viewModel.removeFromFavorites(user)
        }
    }
}

#Preview {
    FavoritesView()
}
