//
//  SettingsView.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 4.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var showingOnboarding = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Uygulama") {
                    Button(action: {
                        showingOnboarding = true
                    }) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                            Text("Tanıtımı Tekrar Göster")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button(action: {
                        // Favorileri temizle
                        FavoritesService.shared.clearAllFavorites()
                    }) {
                        HStack {
                            Image(systemName: "heart.slash")
                                .foregroundColor(.red)
                            Text("Favorileri Temizle")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section("Hakkında") {
                    HStack {
                        Image(systemName: "info")
                            .foregroundColor(.secondary)
                        Text("Versiyon")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: "person.circle")
                            .foregroundColor(.secondary)
                        Text("Geliştirici")
                        Spacer()
                        Text("Berkay Emre Aslan")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Ayarlar")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showingOnboarding) {
            OnboardingView()
        }
    }
}

#Preview {
    SettingsView()
}
