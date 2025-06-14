//
//  ContentView.swift
//  MoodTracker
//
//  Created by GaneshBalaraju on 14/06/25.
//

// In ContentView.swift

// In ContentView.swift

import SwiftUI

struct ContentView: View {
    // In a real app, this would be tied to a persistent login state.
    @State private var isAuthenticated = false

    var body: some View {
        Group {
            if isAuthenticated {
                // This view is shown when the user IS logged in.
                MainTabView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .scale)
                    )
            } else {
                // This view is shown when the user IS NOT logged in.
                LoginView(onLoginSuccess: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isAuthenticated = true
                    }
                })
            }
        }
    }
}

#Preview {
    ContentView()
}

