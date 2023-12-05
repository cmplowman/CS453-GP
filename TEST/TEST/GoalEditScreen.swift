//
//  GoalEditScreen.swift
//  TEST
//
//  Created by Student on 12/5/23.
//

import SwiftUI

struct GoalEditScreen: View {
    @ObservedObject var viewModel: ApiViewModel
    
    @State private var cals = ""
    @State private var fats = ""
    @State private var protein = ""
    @State private var sodium = ""
    @State private var cholest = ""
    @State private var carbs = ""
    @State private var sugars = ""
    
    var body: some View {
        VStack {
            
            TextField("Enter Calorie Goal (cal)", text: $cals)
                .padding()
                .background(CustomTeal.MyTeal.cornerRadius(15))
                .frame(width: 390)
                .padding()
            
            TextField("Enter Fats Goal (g)", text: $fats)
                .padding()
                .background(CustomTeal.MyTeal.cornerRadius(15))
                .frame(width: 390)
                .padding()
            
            TextField("Enter Protein Goal (g)", text: $protein)
                .padding()
                .background(CustomTeal.MyTeal.cornerRadius(15))
                .frame(width: 390)
                .padding()
            
            TextField("Enter Sodium Goal (mg)", text: $sodium)
                .padding()
                .background(CustomTeal.MyTeal.cornerRadius(15))
                .frame(width: 390)
                .padding()
            
            TextField("Enter Cholesterol Goal (mg)", text: $cholest)
                .padding()
                .background(CustomTeal.MyTeal.cornerRadius(15))
                .frame(width: 390)
                .padding()
            
            TextField("Enter Carbohydrates Goal (g)", text: $carbs)
                .padding()
                .background(CustomTeal.MyTeal.cornerRadius(15))
                .frame(width: 390)
                .padding()
            
            TextField("Enter Sugar Goal (g)", text: $sugars)
                .padding()
                .background(CustomTeal.MyTeal.cornerRadius(15))
                .frame(width: 390)
                .padding()
            
            Button("Save") {
                if let cals = Double(cals) {
                    viewModel.weeklyCals = cals
                    viewModel.updateCals(c: cals)
                }
                
                if let fats = Double(fats) {
                    viewModel.weeklyFats = fats
                    print("\(viewModel.weeklyFats)")
                }
                
                if let protein = Double(protein) {
                    viewModel.weeklyProtein = protein
                    print("\(viewModel.weeklyProtein)")
                }
                
                if let sodium = Double(sodium) {
                    viewModel.weeklySodium = sodium
                    print("\(viewModel.weeklySodium)")
                }
                
                if let cholest = Double(cholest) {
                    viewModel.weeklyCholest = cholest
                    print("\(viewModel.weeklyCholest)")
                }
                
                if let carbs = Double(carbs) {
                    viewModel.weeklyCarbs = carbs
                    print("\(viewModel.weeklyCarbs)")
                }
                
                if let sugars = Double(sugars) {
                    viewModel.weeklySugars = sugars
                    print("\(viewModel.weeklySugars)")
                }
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(Color.black)
            .tint(CustomTeal.MyTeal)
            .controlSize(.large)
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

