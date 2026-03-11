//
//  TabItems.swift
//  Gig flow
//
//  Created by Sean Mavangira on 11/3/2026.
//

import SwiftUI

enum Tabs: String{
    case Dashboard
    case Gigs
    case Timer
    case Earnings
    
    
}

struct TabItems: View {
    @State var selected: Tabs = .Dashboard
    var body: some View {
        TabView(selection: $selected) {
            
            NavigationStack {
                DashboardPage(selectedTab: $selected)
                    .navigationTitle("Dashboard")
            }
            .tabItem { Label("Dashboard", systemImage: "house.fill") }
            .tag(Tabs.Dashboard)
            
            
            NavigationStack {
                GigsPage()
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
