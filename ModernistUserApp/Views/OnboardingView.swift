//
//  OnboardingPage.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 2.07.2025.
//

import SwiftUI


enum OnboardingPage: Int, CaseIterable {
    case info
    case usersInfo
    case favoritesInfo
    
    var title: String {
        switch self {
            case .info:
                return "Modernist User App'e Hoş Geldiniz"
            case .usersInfo:
                return "Kullanıcıları Keşfedin"
            case .favoritesInfo:
                return "Favorilerinizi Yönetin"
        }
    }
    
    var description: String {
        switch self {
            case .info:
                return "Kullanıcı yönetimi artık çok daha kolay! Tüm kullanıcıları görüntüleyin, arayın ve favorilerinizi organize edin."
            case .usersInfo:
                return "Kullanıcılar sekmesinde tüm kayıtlı kullanıcıları görüntüleyebilir, arama yapabilir ve detaylarını inceleyebilirsiniz."
            case .favoritesInfo:
                return "Beğendiğiniz kullanıcıları favorilere ekleyerek hızlı erişim sağlayın. Favorilerinizi kolayca yönetin."
        }
    }
}

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0
    @State private var isAnimating = false
    @State private var userInfoOffset = false
    @State private var trackingProgress: CGFloat = 0.0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                    getPageView(for: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.spring(), value: currentPage)
            
            HStack(spacing: 12) {
                ForEach(0..<OnboardingPage.allCases.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.5))
                        .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12 : 8)
                        .animation(.spring(), value: currentPage)
                }
            }
            
            //Button
            Button {
                withAnimation(.spring()) {
                    if currentPage < OnboardingPage.allCases.count - 1 {
                        currentPage += 1
                        
                        //Reset Animation
                        isAnimating = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isAnimating = true
                        }
                    } else {
                        //Handle finish
                        hasCompletedOnboarding = true
                        dismiss()
                    }
                }
            } label: {
                Text(currentPage < OnboardingPage.allCases.count - 1 ? "İleri" : "Başla")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color.blue, Color.blue.opacity(0.5)
                        ]), startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    isAnimating = true
                }
            }
        }
        .onChange(of: currentPage) { _ in
            // Sayfa değiştiğinde animasyonu sıfırla
            isAnimating = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    isAnimating = true
                }
            }
        }
    }
    
    private var infoImageView: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                .frame(width: 250, height: 250)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            
            Image("firstImage")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .offset(y: userInfoOffset ? -20 : 0)
                .rotationEffect(.degrees(userInfoOffset ? 5 : -5))
                .opacity(isAnimating ? 1 : 0)
                .animation(.spring(dampingFraction: 0.3).delay(0.2), value: isAnimating)
            
            ForEach(0..<8) { index in
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .offset(
                        x: 120 * cos(Double(index) * .pi / 4),
                        y: 120 * sin(Double(index) * .pi / 4)
                    )
                    .scaleEffect(isAnimating ? 1 : 0)
                    .opacity(isAnimating ? 0.7 : 0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever()
                        .delay(Double(index) * 0.1),
                        value: isAnimating
                    )
            }
        }
    }
    
    private var userInfoImageView: some View {
        ZStack {
            Image("person1")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .opacity(0.7)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.3).delay(0.2), value: isAnimating)
                .zIndex(1)
            
            Image("person2")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .opacity(0.7)
                .offset(x: -120, y: isAnimating ? 0 : 40)
                .animation(.spring(dampingFraction: 0.3).delay(0.2), value: isAnimating)
            
            Image("person3")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .opacity(0.7)
                .offset(x: 120, y: isAnimating ? 0 : 100)
                .animation(.spring(dampingFraction: 0.3).delay(0.2), value: isAnimating)
        }
    }
    
    private var favoritesInfoImageView: some View {
        ZStack {
            Circle()
                .stroke(Color.red.opacity(0.2), lineWidth: 2)
                .frame(width: 250, height: 250)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundStyle(Color.red)
                .opacity(isAnimating ? 1 : 0)
                .scaleEffect(isAnimating ? 1 : 0.8)
                .rotation3DEffect(.degrees(isAnimating ? 360 : 1), axis: (x: 0, y: 1, z: 0))
                .animation(.spring(dampingFraction: 0.7).delay(0.2), value: isAnimating)
            
            ForEach(0..<4) { index in
                Image(systemName: "heart.fill")
                    .foregroundStyle(Color.red)
                    .offset(
                        x: 100 * cos(Double(index) * .pi / 2),
                        y: 100 * sin(Double(index) * .pi / 2)
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1 : 0)
                    .animation(.spring(dampingFraction: 0.6).delay(Double(index) * 0.1), value: isAnimating)
            }
        }
    }
    
    @ViewBuilder
    private func getPageView(for page: OnboardingPage) -> some View {
        VStack(spacing: 30) {
            
            //Image
            ZStack {
                switch page {
                    case .info:
                        infoImageView
                    case .usersInfo:
                        userInfoImageView
                    case .favoritesInfo:
                        favoritesInfoImageView
                }
            }
            
            //Text
            VStack(spacing: 20) {
                Text(page.title)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
                
                Text(page.description)
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
            }
        }
        .padding(.top, 50)
    }
}

#Preview {
    OnboardingView()
}
