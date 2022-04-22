//
//  MainGameView.swift
//  WirtschaftsSimulation
//
//  Created by Matthias Müller on 21.04.22.
//

import SwiftUI



enum Qualities {
    case veryGood, good, medium, bad, veryBad
}
enum Oss {
    case easy, balanced, hard
}

struct PhoneCreationView: View {
    @EnvironmentObject var appState: AppState
    
    @State public var selectedQualitie = Qualities.medium
    @State public var selectedOs = Oss.balanced
    
    public var qualitie: Float {
        switch selectedQualitie {
        case .veryGood:
            return 0.8
        case .good:
            return 0.6
        case .medium:
            return 0.5
        case .bad:
            return 0.3
        case .veryBad:
            return 0.1
        }
    }
    
    
    public var os: [Float] {
        switch selectedOs {
        case .easy:
            return [0, 0, 0.1]
        case .balanced:
            return [0, 0.1, 0]
        case .hard:
            return [0.1, 0, 0]
        }
    }
    
    func priceVsCompetitor(price: Float) -> Float {
        let randomPrice: Float = Float.random(in: price - 100...price + 100)
        
        if price < randomPrice {
            return 0.3
        }
        else if price > randomPrice {
            return 0.1
        }
        else {
            return 0
        }
    }
    
    func phonePopularityByAge(quality: Float, price: Float, os: [Float]) -> [Float] {
        var popularity: [Float] = []
        let priceMod: Float = priceVsCompetitor(price: price)
        
        for osMod in os {
            var singlePopularity: Float = osMod + quality + priceMod
            if singlePopularity > 1 {
                singlePopularity = 1
            }
            else {
                singlePopularity = osMod + quality + priceMod
            }
            
            popularity.append(singlePopularity)
        }
        
        return popularity
    }
    
    var body: some View {
        VStack {
            Text("Bau dein erstes Handy:")
                .font(.title)
                .padding(.bottom, 50.0)
            
            Picker("Qualität", selection: $selectedQualitie) {
                Text("Sehr Gut")
                    .tag(Qualities.veryGood)
                Text("Gut")
                    .tag(Qualities.good)
                Text("Mittel")
                    .tag(Qualities.medium)
                Text("Schlecht")
                    .tag(Qualities.bad)
                Text("Sehr Schlecht")
                    .tag(Qualities.veryBad)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            HStack {
                Text("Preis: ")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                TextField("Preis: ", value: $appState.phonePrice, format: .number)
                    .font(.title2)
                    .keyboardType(.numberPad)
                Text("€")
            }
            Slider(value: $appState.phonePrice, in: 0...2000, step: 50)
            
            HStack {
                Text("Menge: ")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                TextField("Menge: ", value: $appState.phoneCount, format: .number)
                    .font(.title2)
                    .keyboardType(.numberPad)
            }
            Slider(value: $appState.phoneCount, in: 0...100000, step: 100)
            
            Picker("OS", selection: $selectedOs) {
                Text("Einfach")
                    .tag(Oss.easy)
                Text("Mittel")
                    .tag(Oss.balanced)
                Text("Schwer")
                    .tag(Oss.hard)
                
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("Lauch"){
                appState.hasLauched = true
                appState.popularity = phonePopularityByAge(quality: qualitie, price: appState.phonePrice, os: os)
            }
        }
    }
}

struct MainFlowView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneCreationView()
    }
}
