//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//


import SwiftUI

struct BottomNavView: View {
    @StateObject var router = AppRouter()

    var body: some View {
        TabView {
            HomeView(router: router)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
            
            ProfileView(router: router)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    BottomNavView()
}

