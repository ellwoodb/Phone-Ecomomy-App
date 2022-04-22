//
//  WirtschaftsSimulationApp.swift
//  Shared
//
//  Created by Matthias Müller on 20.04.22.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var hasOnboarded: Bool
    @Published var hasLauched: Bool
    
    @Published var budget: Float
    @Published var population: Float
    @Published var ageDistr: [Float]
    @Published var factories: Float
    
    @Published var phonePrice: Float
    @Published var phoneCount: Float
    
    @Published var popularity: [Float]
    init(hasOnboarded: Bool, hasLauched: Bool, budget: Float, population: Float, ageDistr: [Float], phonePrice: Float, phoneCount: Float, popularity: [Float], factories: Float) {
        self.hasOnboarded = hasOnboarded
        self.budget = budget
        self.population = population
        self.ageDistr = ageDistr
        self.phonePrice = phonePrice
        self.phoneCount = phoneCount
        self.hasLauched = hasLauched
        self.popularity = popularity
        self.factories = factories
    }
    
    
}

@main
struct OnboardingFlowTestApp: App {
    private var age: [Float] = StartGameView().age
    @ObservedObject var appState = AppState(hasOnboarded: false, hasLauched: false, budget: 0, population: 0, ageDistr: [0, 0, 0], phonePrice: 0, phoneCount: 0, popularity: [0, 0, 0], factories: 1)
    
    var body: some Scene {
        // Wechseln der verschiedenen Views
        WindowGroup {
            if !appState.hasOnboarded && !appState.hasLauched {
                StartGameView()
                    .environmentObject(appState)
            }
            else if appState.hasOnboarded && !appState.hasLauched {
                PhoneCreationView()
                    .environmentObject(appState)
            }
            else if appState.hasOnboarded && appState.hasLauched {
                SalesView()
                    .environmentObject(appState)
            }
            
        }
    }
}

