//
//  ContentView.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 1.07.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        TabView {
            UsersView()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Kullanıcılar")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favoriler")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Ayarlar")
                }
        }
        .accentColor(.blue)
        .onAppear {
            // Uygulama ilk açıldığında TabView'ı aktif et
        }
    }
}


#Preview {
    ContentView()
}
