//
//  FavoritesService.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 1.07.2025.
//

import Foundation


class FavoritesService: ObservableObject {
    static let shared = FavoritesService()
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favoriteUsers"
    
    @Published var favoriteUserIds: Set<Int> = []
    private var favoriteUsers: [User] = []
    
    private init() {
        loadFavorites()
    }
    
    private func loadFavorites() {
        guard let data = userDefaults.data(forKey: favoritesKey) else {
            favoriteUserIds = []
            favoriteUsers = []
            return
        }
        
        let users = (try? JSONDecoder().decode([User].self, from: data)) ?? []
        favoriteUsers = users
        favoriteUserIds = Set(users.map { $0.id })
    }
    
    func getFavorites() -> [User] {
        return favoriteUsers
    }
    
    func addToFavorites(_ user: User) {
        guard !favoriteUserIds.contains(user.id) else { return }
        
        favoriteUsers.append(user)
        favoriteUserIds.insert(user.id)
        saveFavorites()
        
        // UI güncellemesini zorla
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func removeFromFavorites(_ user: User) {
        guard favoriteUserIds.contains(user.id) else { return }
        
        favoriteUsers.removeAll { $0.id == user.id }
        favoriteUserIds.remove(user.id)
        saveFavorites()
        
        // UI güncellemesini zorla
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func clearAllFavorites() {
        favoriteUsers.removeAll()
        favoriteUserIds.removeAll()
        userDefaults.removeObject(forKey: favoritesKey)
        
        // UI güncellemesini zorla
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func isFavorite(_ user: User) -> Bool {
        return favoriteUserIds.contains(user.id)
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteUsers) {
            userDefaults.set(data, forKey: favoritesKey)
        }
    }
}
