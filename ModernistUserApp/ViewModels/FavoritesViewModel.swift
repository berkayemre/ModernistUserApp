//
//  FavoritesViewModel.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 1.07.2025.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favoriteUsers: [User] = []
    
    private let favoritesService = FavoritesService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadFavorites()
        
        // FavoritesService'deki değişiklikleri dinle
        favoritesService.$favoriteUserIds
            .sink { [weak self] _ in
                self?.loadFavorites()
            }
            .store(in: &cancellables)
    }
    
    func loadFavorites() {
        DispatchQueue.main.async {
            self.favoriteUsers = self.favoritesService.getFavorites()
        }
    }
    
    func removeFromFavorites(_ user: User) {
        favoritesService.removeFromFavorites(user)
    }
    
    func toggleFavorite(for user: User) {
        if favoritesService.isFavorite(user) {
            favoritesService.removeFromFavorites(user)
        } else {
            favoritesService.addToFavorites(user)
        }
    }
    
    func isFavorite(_ user: User) -> Bool {
        favoritesService.isFavorite(user)
    }
}
