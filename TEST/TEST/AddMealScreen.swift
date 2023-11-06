//
//  AddMealScreen.swift
//  TEST
//
//  Created by Christoph Koch-Paiz on 11/2/23.
//

import SwiftUI

struct AddMealScreen: View {
    @State var pickerSelection = ""
    @State var pickerSelection2 = ""

    @State var customMeal = ""
//    let meal1 = Meal(name: "Eggs", id: 1)
//    let meal2 = Meal(name: "Bacon", id: 1)
//    let meal3 = Meal(name: "Bacon", id: 1)
    var mealsExample = ["Custom Meal", "Favorites","Bacon", "Turkey", "Oatmeal"]
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
                        
                        ForEach(mealsExample, id: \.self) { meal in
                            Text(meal)
                        }})
                    
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
                            Picker(selection: $pickerSelection2, label: Text("Select From Favorites"), content: {
                                
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
                
                
                //favorite button
                Button{
                    if !customMeal.isEmpty
                    {
                        favoritedMeals.append(customMeal)
                    }
                    else if pickerSelection == "Custom Meal" && customMeal.isEmpty
                    {
                       //Do nothing
                    }
                    else if pickerSelection == "Favorites"
                    {
                        //alert that says already exists in favorites
                        showingAlert2.toggle()

                    }
                    else
                    {
                        if favoritedMeals.contains(pickerSelection)
                        {
                            showingAlert2.toggle()
                        }
                        else{
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
                        addedMeal.append(pickerSelection2)
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


//Model


struct AddMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddMealScreen()
    }
}
