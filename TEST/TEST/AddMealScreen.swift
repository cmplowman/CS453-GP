//
//  AddMealScreen.swift
//  TEST
//
//  Created by Christoph Koch-Paiz on 11/2/23.
//

import SwiftUI

struct AddMealScreen: View {
    @ObservedObject var viewModel: ApiViewModel
    @State var favoritedMeals: [Food] = []
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false
    @State var choice: [String] = ["Custom Meal", "Favorites"]
    @State var pickerSelection = "Custom Meal"
    @State var favoriteSelection = ""
    
    
    var body: some View {
        NavigationView{
            ZStack{
                CustomTeal.MyTeal
                VStack {
                    Form{
                        Picker(selection: $pickerSelection, label: Text("Select Meal"), content: {
                            
                            ForEach(choice, id: \.self) { choice in
                                Text(choice)
                            }
                        })
                        
                        if pickerSelection == "Custom Meal"
                        {
                            TextField("Custom Meal", text: $viewModel.query)
                            
                        }
                        else{
                            
                            if favoritedMeals.isEmpty
                            {
                                Button("Show Alert")
                                {
                                    showingAlert1.toggle()
                                }
                                
                            }
                            //                            else {
                            //                                Picker(selection: $favoriteSelection, label: Text("Select From Favorites"), content: {
                            //
                            //                                    ForEach(favoritedMeals) { meal in
                            //                                        Text(meal.name).tag(meal)
                            //                                    }
                            //                                })
                            //                            }
                        }
                        Button("Show Nutritional Values") {
                            viewModel.getNutrition(query: viewModel.query)
                        }
                    }
                    
                    .background(CustomTeal.MyTeal)
                    .scrollContentBackground(.hidden)
                    .alert(isPresented: $showingAlert1) {
                        
                        Alert(
                            title: Text("No Favorites"),
                            message: Text("You have no favorites. Favorite a meal to see them here."),
                            dismissButton: .cancel())
                    }
                    
                    List {
                        ForEach(viewModel.foods) { food in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(food.name)")
                                        .font(.title)
                                        .padding(.bottom)
                                }
                                .minimumScaleFactor(0.01)
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Serving Size: \(String(format: "%.1f", food.serving_size_g))g")
                                    Text("Total Fat: \(String(format: "%.1f", food.fat_total_g))g")
                                    Text("Saturated Fat: \(String(format: "%.1f", food.fat_saturated_g))g")
                                    Text("Protein: \(String(format: "%.1f", food.protein_g))g")
                                    Text("Sodium: \(String(format: "%.1f", food.sodium_mg)) mg")
                                    Text("Potassium: \(String(format: "%.1f", food.potassium_mg))mg")
                                    Text("Cholesterol: \(String(format: "%.1f", food.cholesterol_mg))mg")
                                    Text("Carbohydrates: \(String(format: "%.1f", food.carbohydrates_total_g))g")
                                    Text("Fiber: \(String(format: "%.1f", food.fiber_g))g")
                                    Text("Sugar: \(String(format: "%.1f", food.sugar_g))g")
                                }
                            }
                            .padding()
                        }
                    }
                    
                    Spacer()
                    
                    //favorite button
                    Button {
        
                        
                    } label: {
                        Label("Favorite", systemImage: "star.fill")
                            .frame(width: 340)
                            .font(.system(size: 30))
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(CustomTeal.MyTeal)
                    .tint(.white)
                    .controlSize(.large)
                    
                    
                    .alert(isPresented: $showingAlert2) {
                        
                        Alert(
                            title: Text("Duplicate Favorite"),
                            message: Text("You have already favorited this Meal"),
                            dismissButton: .cancel())
                    }
                    
                    //add meal button
                    Button {
                        
                        // send food obj to weekly screen here
                        
                        //                        if query != ""
                        //                        {
                        //                            //addedMeal.append(customMeal)
                        //                        }
                        //                        else if pickerSelection.name == "Favorites"
                        //                        {
                        //                            // addedMeal.append(favoriteSelection)
                        //                        }
                        //                        else if pickerSelection.name == "Custom Meal" && query.isEmpty
                        //                        {
                        //                            //Do nothing
                        //                        }
                        //                        else
                        //                        {
                        //                            addedMeal.append(pickerSelection)
                        //                        }
                        
                    } label: {
                        Label("Add Meal", systemImage: "fork.knife.circle.fill")
                            .frame(width: 340)
                            .font(.system(size: 30))
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(CustomTeal.MyTeal)
                    .tint(.white)
                    .controlSize(.large)
                    .background(CustomTeal.MyTeal).frame(width: .infinity)
                }
                .navigationTitle("Add Meal")
            }
        }
    }
}

struct AddMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddMealScreen(viewModel: ApiViewModel())
    }
}
