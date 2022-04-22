//
//  ContentView.swift
//  Shared
//
//  Created by Matthias Müller on 20.04.22.
//

import SwiftUI

enum Ages {
    case young, balanced, old
}

struct StartGameView: View {
    @EnvironmentObject var appState: AppState
    
    @State public var selectedAges = Ages.balanced
    
    public var age: [Float] {
        switch selectedAges {
        case .young:
            return [0.6, 0.2, 0.2]
        case .balanced:
            return [0.33, 0.33, 0.33]
        case .old:
            return [0.2, 0.2, 0.6]
        }
    }
    
    var body: some View {
        VStack {
            Text("Startparameter:")
                .font(.title)
                .padding(.bottom, 50.0)
            
            //Budget Auswahl
            HStack {
                Text("Startbudget: ")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                TextField("Budget: ", value: $appState.budget, format: .number)
                    .font(.title2)
                    .keyboardType(.numberPad)
                Text("€")
            }
            Slider(value: $appState.budget, in: 0...1000000, step: 5)
            
            //Population Auswahl
            HStack {
                Text("Kunden: ")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                TextField("Kunden: ", value: $appState.population, format: .number)
                    .font(.title2)
                    .keyboardType(.numberPad)
            }
            Slider(value: $appState.population, in: 0...100000, step: 100)
            
            //Agedistr Auswahl
            Text("Alter: ")
                .font(.title2)
            Picker("Alter", selection: $selectedAges) {
                Text("Jung")
                    .tag(Ages.young)
                Text("Ausgegglichen")
                    .tag(Ages.balanced)
                Text("Alt")
                    .tag(Ages.old)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Stepper("Fabriken: \(Int(appState.factories))", value: $appState.factories)

            Button("Start Simulation!"){
                appState.ageDistr = age
                appState.hasOnboarded = true
            }
        }
        .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
        .actionSheet(isPresented: $appState.factoriesUnderOne) {
            ActionSheet(
                title: Text("Actions"),
                message: Text("Achtung"),
                buttons: [
                    .default(Text("Actishdjahf"))
                ]
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartGameView()
    }
}
