//
//  AddMealScreen.swift
//  TEST
//
//  Created by Christoph Koch-Paiz on 11/2/23.
//

import SwiftUI

struct AddMealScreen: View {
    @State var pickerSelection = "Eggs"
    @State var customMeal = ""
//    let meal1 = Meal(name: "Eggs", id: 1)
//    let meal2 = Meal(name: "Bacon", id: 1)
//    let meal3 = Meal(name: "Bacon", id: 1)
    var mealsExample = ["Custom Meal", "Bacon", "Turkey", "Oatmeal"]
    @State var favoritedMeals: [String] = []
    @State var addedMeal: [String] = []

    
    var selectedMeals: [String] = []

    
    var body: some View {
        
        NavigationView{
            VStack {
                
                
                Form{
                    Picker(selection: $pickerSelection, label: Text("Choose Meal"), content: {
                        ForEach(mealsExample, id: \.self) { meal in
                            Text(meal)
                        }})
                    
                    
                    if pickerSelection == "Custom Meal"
                    {
                        TextField("Custom Meal", text: $customMeal)
                    }
                    
                }
                
                
                //testing purposes
                ForEach(favoritedMeals, id: \.self) { meal in
                    Text(meal)
                }
                
                
                
                
                Button{
                    if customMeal != ""
                    {
                        favoritedMeals.append(customMeal)
                    }
                    else
                    {
                        favoritedMeals.append(pickerSelection)
                    }
          
                    
                }label: {
                    Label("Favorite", systemImage: "star.fill")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 30))
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .controlSize(.large)
                
                Button{
                    if customMeal != ""
                    {
                        addedMeal.append(customMeal)
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

//Model


struct AddMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddMealScreen()
    }
}
