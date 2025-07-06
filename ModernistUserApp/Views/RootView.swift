//
//  RootView.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 3.07.2025.
//

import Foundation
import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some View {
        if hasCompletedOnboarding {
            ContentView()
        } else {
            OnboardingView()
        }
    }
}
