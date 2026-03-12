//
//  TabItems.swift
//  Gig flow
//
//  Created by Sean Mavangira on 11/3/2026.
//

import SwiftUI



struct TabItems: View {
    @State var selected: Tabs = .Dashboard
    @State var gigStore = GigStore()
    var body: some View {
        TabView(selection: $selected) {
            
            NavigationStack {
                DashboardPage(selectedTab: $selected, gigStore: $gigStore)
                    .navigationTitle("Dashboard")
            }
            .tabItem { Label("Dashboard", systemImage: "house.fill") }
            .tag(Tabs.Dashboard)
            
            
            NavigationStack {
                GigsPage(gigStore: gigStore)
                    .navigationTitle("Gigs")
            }
            .tabItem { Label("Gigs", systemImage: "briefcase.fill") }
            .tag(Tabs.Gigs)
            
            
            NavigationStack {
                TimerPage()
                    .navigationTitle("Timer")
            }
            .tabItem { Label("Timer", systemImage: "clock.fill") }
            .tag(Tabs.Timer)
            
            
            NavigationStack {
                EarningsPage()
                    .navigationTitle("Earnings")
            }
            .tabItem { Label("Earnings", systemImage: "chart.bar.fill") }
            .tag(Tabs.Earnings)
        }
    }
}

#Preview {
    TabItems()
}

