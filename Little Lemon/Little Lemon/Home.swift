//
//  Home.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 11/11/2024.
//

import SwiftUI

struct Home: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let persistence = PersistenceController.shared
    
    var body: some View {
        
        TabView {
            Tab("Menu", systemImage: "list.dash") {
                Menu().environment(\.managedObjectContext, persistence.container.viewContext)
            }
            
            Tab("Profile", systemImage: "square.and.pencil") {
                UserProfile(dismiss: dismiss)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            let standardAppearance = UITabBarAppearance()
            
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.primary1.withAlphaComponent(0.5)]
            itemAppearance.normal.iconColor = UIColor.primary1.withAlphaComponent(0.3)
            
            
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.primary1]
            itemAppearance.selected.iconColor = UIColor.secondary1
            
            standardAppearance.inlineLayoutAppearance = itemAppearance
            standardAppearance.stackedLayoutAppearance = itemAppearance
            standardAppearance.compactInlineLayoutAppearance = itemAppearance
            UITabBar.appearance().standardAppearance = standardAppearance
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    Home()
}
