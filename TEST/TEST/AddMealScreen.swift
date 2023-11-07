//
//  AddMealScreen.swift
//  TEST
//
//  Created by Christoph Koch-Paiz on 11/2/23.
//

import SwiftUI

struct AddMealScreen: View {
    @State var pickerSelection = "Custom Meal"
    @State var favoriteSelection = ""

    @State var customMeal = ""

    var mealsExample:[testMeal] = [
        testMeal(name: "Pasta", id: 1, calories: 500),
        testMeal(name: "Pizza", id: 2, calories: 700),
        testMeal(name: "Salad", id: 3, calories: 300),
        testMeal(name: "Chicken", id: 4, calories: 200),
        testMeal(name: "Tacos", id: 5, calories: 300),
        testMeal(name: "Soup", id: 6, calories: 150),
        testMeal(name: "Custom Meal", id: 7, calories: 0),
        testMeal(name: "Favorites", id: 8, calories: 0)
    ]

        
        
       //Need to change type from String to testMeal
    @State var favoritedMeals: [String] = []
    @State var addedMeal: [String] = []
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false

    

    
    var selectedMeals: [String] = []

    
    var body: some View {
        
        NavigationView{
            VStack {
                
                
                Form{
                    Picker(selection: $pickerSelection, label: Text("Choose Meal"), content: {
                        
                        ForEach(mealsExample) { meal in
                            Text(meal.name).tag(meal.name)
                        }
                        
                        
                    })
                    
                    if pickerSelection == "Custom Meal"
                    {
                        TextField("Custom Meal", text: $customMeal)
                    }
                    
                    else if pickerSelection == "Favorites"
                    {
                        if favoritedMeals.isEmpty
                        {
                            Button("Show Alert")
                            {
                                showingAlert1.toggle()
                            }
                            
                        }
                        else{
                            Picker(selection: $favoriteSelection, label: Text("Select From Favorites"), content: {
                                
                                ForEach(favoritedMeals, id: \.self) { meal in
                                    Text(meal)
                                }})

                       

                            
                        }
                    }
                }
                .alert(isPresented: $showingAlert1) {
                    
                    Alert(
                        title: Text("No Favorites"),
                        message: Text("You have no favorites. Favorite a meal to see them here."),
                        dismissButton: .cancel())
                }
                
                
                
//                ForEach(favoritedMeals, id: \.self) { meal in
//                                    Text(meal)
//                                }
//                ForEach(addedMeal, id: \.self) { meal in
//                    Text(meal)
//                }
//                
                
                //favorite button
                Button{
                    if !customMeal.isEmpty {
                        if favoritedMeals.contains(customMeal) {
                            showingAlert2.toggle()
                        } else {
                            favoritedMeals.append(customMeal)
                        }
                    } else if pickerSelection == "Custom Meal" && customMeal.isEmpty {
                        // Do nothing
                    } else if pickerSelection == "Favorites" {
                        showingAlert2.toggle()
                    } else {
                        if favoritedMeals.contains(pickerSelection) {
                            showingAlert2.toggle()
                        } else {
                            favoritedMeals.append(pickerSelection)
                        }
                    }
                    
                }label: {
                    Label("Favorite", systemImage: "star.fill")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 30))
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .controlSize(.large)
                
                .alert(isPresented: $showingAlert2) {
                    
                    Alert(
                        title: Text("Duplicate Favorite"),
                        message: Text("You have already favorited this Meal"),
                        dismissButton: .cancel())
                }
                
                //add meal button
                Button{
                    if customMeal != ""
                    {
                        addedMeal.append(customMeal)
                    }
                    else if pickerSelection == "Favorites"
                    {
                        addedMeal.append(favoriteSelection)
                    }
                    else if pickerSelection == "Custom Meal" && customMeal.isEmpty
                    {
                        //Do nothing
                    }
                    else
                    {
                        addedMeal.append(pickerSelection)
                    }

                }label: {
                    Label("Add Meal", systemImage: "fork.knife.circle.fill")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 30))
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .controlSize(.large)
                
                
                
            }
            .navigationTitle("Add Meal")
        }
    }
}


//Test Model

struct testMeal: Identifiable {
    let name: String
    let id: Int
    let calories: Int
}





struct AddMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddMealScreen()
    }
}
