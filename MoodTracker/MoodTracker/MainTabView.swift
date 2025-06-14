//
//  MainTabView.swift
//  MoodTracker
//
//  Created by GaneshBalaraju on 14/06/25.
//


// In MainTabView.swift

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                MoodLogView()
                    .navigationBarHidden(true)
            }
            .tabItem {
                Label("Check-in", systemImage: "pencil.and.scribble")
            }
            
            ProgressView()
                .tabItem {
                    Label("Journey", systemImage: "chart.bar.xaxis")
                }
        }
        .accentColor(Color(red: 0.3, green: 0.5, blue: 0.6))
    }
}
