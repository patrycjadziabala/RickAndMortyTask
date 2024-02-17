//
//  RickAndMortyTaskApp.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import SwiftUI

@main
struct RickAndMortyTaskApp: App {
    
    @StateObject var persistanceManager: PersistenceManager = PersistenceManager()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .environmentObject(persistanceManager)
        }
    }
}
