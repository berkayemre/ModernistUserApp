//
//  UsersView.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 1.07.2025.
//

import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Kullanıcılar yükleniyor...")
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    Spacer()
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text("Hata oluştu")
                            .font(.headline)
                        Text(errorMessage)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                        Button("Tekrar Dene") {
                            viewModel.fetchUsers()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    Spacer()
                } else {
                    // Kullanıcı listesi
                    List(viewModel.filteredUsers) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            UserRowView(
                                user: user,
                                isFavorite: viewModel.isFavorite(user),
                                onFavoriteToggle: {
                                    viewModel.toggleFavorite(for: user)
                                }
                            )
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Kullanıcılar")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $viewModel.searchText, prompt: "Kullanıcı ara...")
            .refreshable {
                viewModel.fetchUsers()
            }
            .onAppear {
                // View görünür olduğunda kullanıcıları yükle
                viewModel.fetchUsersIfNeeded()
            }
        }
    }
}


#Preview {
    UsersView()
}
