//
//  UserDetailView.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 1.07.2025.
//

import SwiftUI


struct UserDetailView: View {
    let user: User
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Profil bölümü
                VStack {
                    AsyncImage(url: URL(string: user.profileImageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    
                    Text(user.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("@\(user.username)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                
                // İletişim bilgileri
                DetailSection(title: "İletişim") {
                    DetailRow(icon: "envelope", title: "E-posta", value: user.email)
                    DetailRow(icon: "phone", title: "Telefon", value: user.phone)
                    DetailRow(icon: "globe", title: "Website", value: user.website)
                }
                
                // Adres bilgileri
                DetailSection(title: "Adres") {
                    DetailRow(icon: "location", title: "Adres", value: user.address.fullAddress)
                    DetailRow(icon: "map", title: "Koordinat", value: "\(user.address.geo.lat), \(user.address.geo.lng)")
                }
                
                // Şirket bilgileri
                DetailSection(title: "Şirket") {
                    DetailRow(icon: "building.2", title: "Şirket", value: user.company.name)
                    DetailRow(icon: "quote.bubble", title: "Slogan", value: user.company.catchPhrase)
                    DetailRow(icon: "briefcase", title: "İş Alanı", value: user.company.bs)
                }
            }
            .padding()
        }
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    favoritesViewModel.toggleFavorite(for: user)
                }) {
                    Image(systemName: favoritesViewModel.isFavorite(user) ? "heart.fill" : "heart")
                        .foregroundColor(favoritesViewModel.isFavorite(user) ? .red : .gray)
                }
            }
        }
    }
}

struct DetailSection<Content: View>: View {
    let title: String
    let content: () -> Content
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            VStack(spacing: 8) {
                content()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.accentColor)
                .frame(width: 20)
            
            Text(title)
                .foregroundColor(.secondary)
                .frame(width: 80, alignment: .leading)
            
            Text(value)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

#Preview {
    UserDetailView(user: User.mockUser)
}
