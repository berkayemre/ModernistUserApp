//
//  UsersViewModel 2.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 3.07.2025.
//
import SwiftUI
import Combine

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService.shared
    private let favoritesService = FavoritesService.shared
    private var hasInitiallyFetched = false
    
    init() {
        setupSearchFilter()
        
        // FavoritesService'deki değişiklikleri dinle
        favoritesService.$favoriteUserIds
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func fetchUsers() {
        // Çoklu çağrıları önle
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        apiService.fetchUsers()
            .sink(
                receiveCompletion: { [weak self] completion in
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        if case .failure(let error) = completion {
                            self?.errorMessage = error.localizedDescription
                        }
                    }
                },
                receiveValue: { [weak self] users in
                    DispatchQueue.main.async {
                        self?.users = users
                        self?.hasInitiallyFetched = true
                        // İlk yükleme sonrası filtrelemeyi tetikle
                        self?.filterUsers(with: self?.searchText ?? "")
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    func fetchUsersIfNeeded() {
        if !hasInitiallyFetched && !isLoading {
            fetchUsers()
        }
    }
    
    private func setupSearchFilter() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.filterUsers(with: searchText)
            }
            .store(in: &cancellables)
        
        // users array'i değiştiğinde de filtrelemeyi tetikle
        $users
            .sink { [weak self] _ in
                self?.filterUsers(with: self?.searchText ?? "")
            }
            .store(in: &cancellables)
    }
    
    private func filterUsers(with searchText: String) {
        let usersToFilter = users
        
        if searchText.isEmpty {
            filteredUsers = usersToFilter
        } else {
            filteredUsers = usersToFilter.filter { user in
                user.name.localizedCaseInsensitiveContains(searchText) ||
                user.email.localizedCaseInsensitiveContains(searchText) ||
                user.username.localizedCaseInsensitiveContains(searchText)
            }
        }
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
