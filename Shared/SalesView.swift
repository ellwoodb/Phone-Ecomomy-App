//
//  SalesView.swift
//  WirtschaftsSimulation
//
//  Created by Matthias Müller on 22.04.22.
//

import SwiftUI



struct SalesView: View {
    @EnvironmentObject var appState: AppState
    
    func soldPhones(phoneCount: Int, popularity: [Float], population: Float, ageDistr: [Float]) -> Int {
        var possibleSalesInAgeGroup: [Float] = []
        for ageGroup in ageDistr {
            possibleSalesInAgeGroup.append(population * ageGroup)
        }
        var sales: Float = 0
        for possibleSale in possibleSalesInAgeGroup {
            for agePopularity in popularity {
                sales = possibleSale * agePopularity + sales
            }
        }
        if Int(sales) >= phoneCount {
            return Int(phoneCount)
        }
        else {
            return Int(sales)
        }
    }
    
    func isPhoneSoldOut(soldPhones: Float, producedPhones: Float) -> Bool {
        if soldPhones == producedPhones {
            return true
        } else {
            return false
        }
    }
    
    func addBudget(soldPhones: Int, pricePerPhone: Float) -> Int {
        let budgetToAdd = soldPhones * Int(pricePerPhone)
        appState.budget = appState.budget + Float(budgetToAdd)
        return Int(appState.budget)
    }
    
    var body: some View {
        Text("Popularity: \(round(appState.popularity[0] * 100) / 100.0), \(round(appState.popularity[1] * 100) / 100.0), \(round(appState.popularity[2] * 100) / 100.0)")
        
        Text("Handys Produziert: \(Int(appState.phoneCount))")
        let phonesSold: Int = soldPhones(phoneCount: Int(appState.phoneCount), popularity: appState.popularity, population: appState.population, ageDistr: appState.ageDistr)
        Text("Handys Verkauft: \(phonesSold)")
        Text("Sold out: \(String(isPhoneSoldOut(soldPhones: Float(phonesSold), producedPhones: appState.phoneCount)))")
        Text("Budget: \(addBudget(soldPhones: phonesSold, pricePerPhone: appState.phonePrice))€")
        
        Button("Nochmal!"){
            appState.hasLauched = false
        }
    }
}

struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
    }
}
