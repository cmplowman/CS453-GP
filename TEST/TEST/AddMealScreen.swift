//
//  AddMealScreen.swift
//  TEST
//
//  Created by Christoph Koch-Paiz on 11/2/23.
//

import SwiftUI

struct AddMealScreen: View {
    @ObservedObject var viewModel: ApiViewModel
    @Binding var showingAddMeal: Bool
//    @Binding var plsStop: Bool
   // @Binding var currentDayID: Int
    //@Binding var currentMealSlot: MealType
    @State var favoritedMeals: [Food] = []
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false
    @State var choice: [String] = ["Custom Meal", "Favorites"]
    @State var pickerSelection = "Custom Meal"
    
    @State var foodItem = Food(name: "Chicken", calories: 0.0, serving_size_g: 0.0, fat_total_g: 0.0, fat_saturated_g: 0.0, protein_g: 0.0, sodium_mg: 0.0, potassium_mg: 0.0, cholesterol_mg: 0.0, carbohydrates_total_g: 0.0, fiber_g: 0.0, sugar_g: 0.0)
    
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
                            
                            if viewModel.favoritesList.isEmpty
                            {
                                Button("Show Alert")
                                {
                                    showingAlert1.toggle()
                                }
                                
                            }
                            else{
                                
                                Picker("Select From Favorites", selection: $foodItem) {
                                    ForEach(viewModel.favoritesList) { fav in
                                        Text("\(fav.name.prefix(1).capitalized + fav.name.dropFirst())").tag(fav)
                                    }
                                }
                            }
                        }
                        Button("Show Nutritional Values") {
                            if pickerSelection == "Custom Meal"
                            {
                                viewModel.getNutrition(query: viewModel.query)
                            }
                            else{
                                viewModel.query = foodItem.name
                                viewModel.getNutrition(query: viewModel.query)
                            }
                        }
                        List {
                            ForEach(viewModel.foods) { food in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(food.name.prefix(1).capitalized + food.name.dropFirst())")                                            .font(.title)
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
                    }
                    
                    .background(CustomTeal.MyTeal)
                    .scrollContentBackground(.hidden)
                    .alert(isPresented: $showingAlert1) {
                        
                        Alert(
                            title: Text("No Favorites"),
                            message: Text("You have no favorites. Favorite a meal to see them here."),
                            dismissButton: .cancel())
                    }
                    
                    
                    
                    Spacer()
                    
                    //favorite button
                    Button {
                        
                        let food = viewModel.combineFoods()
                        if !viewModel.favoritesList.contains(where: { $0.name == food.name }) {
                            viewModel.addFavorite(f: food)
                        } else {
                            showingAlert2.toggle()
                        }
                        
                        
                    }label: {
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
                        let food = viewModel.combineFoods()
                        let dayOfWeek = viewModel.dayOfWeek
                        let timeOfDay = viewModel.time
                        print("DOW: \(dayOfWeek)")
                        print(viewModel.dayOfWeek)
                        print("TOD: \(timeOfDay)")
                        print(viewModel.time)
                        
//                        if it is breakfast
                        if timeOfDay == 1
                        {
                            viewModel.addBreakfast(f: food, dayNum: dayOfWeek)
                        }
                        else if timeOfDay == 2
                        {
                            viewModel.addLunch(f: food, dayNum: dayOfWeek)
                        }
                        else if timeOfDay == 3
                        {
                            viewModel.addDinner(f: food, dayNum: dayOfWeek)
                        }
                        showingAddMeal.toggle()
                        
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

//struct AddMealScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddMealScreen(viewModel: ApiViewModel())
//    }
//}
