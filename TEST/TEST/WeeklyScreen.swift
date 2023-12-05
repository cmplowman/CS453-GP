//
//  WeeklyScreen.swift
//  TEST
//
//  Created by Peter Hope on 10/31/23.
//
//  Goal:
//      display an overview of the current week
//  Look:
//      each day of week has a row
//          Day name
//              open that days page
//                  has each meal and options to add
//          B, L, D under day
//              meal name if filled
//              click to see:
//                  more details on that meal
//                  -or-
//                  add meal to that slot


import SwiftUI


struct fakeView: View {
    var body: some View {
        Color.red
            .edgesIgnoringSafeArea(.all)
            .overlay(Text("View 1").foregroundColor(.white))
    }
}

enum MealType {
    case breakfast, lunch, dinner
}





//
//View
//
//Week Screen
struct WeeklyScreen: View {
    @ObservedObject var viewModel: ApiViewModel
    @State private var showingAddMeal = false
    @State private var showingMealDetails = false
    @State private var selectedMeal: Food?
    
    
    var body: some View {
        VStack {
            Text("Week").font(.largeTitle)
            //loops through each day in the week
            List(viewModel.week) { day in
                VStack(alignment: .leading) {
                    Text(day.name).font(.title)
                        .foregroundColor(Color.black)
                    
                    //Day
                    HStack {
                        //breakfast
                        MealView(mealType: .breakfast, meal: day.breakfast,
                                 addMealAction: { self.showingAddMeal = true },
                                 showMealDetailsAction: { meal in
                            self.selectedMeal = meal
                            self.showingMealDetails = true
                        })
                        //lunch
                        MealView(mealType: .lunch, meal: day.lunch,
                                 addMealAction: { self.showingAddMeal = true },
                                 showMealDetailsAction: { meal in
                            self.selectedMeal = meal
                            self.showingMealDetails = true
                        })
                        //dinner
                        MealView(mealType: .dinner, meal: day.dinner,
                                 addMealAction: { self.showingAddMeal = true },
                                 showMealDetailsAction: { meal in
                            self.selectedMeal = meal
                            self.showingMealDetails = true
                        })
                        
                        
                    }
                }
            }
        }
        
        //opens meal details view
        .sheet(isPresented: $showingMealDetails, onDismiss: { self.selectedMeal = nil }) {
            if let meal = selectedMeal {
                MealDetailsView(meal: meal)
            }
        }
        //opens add meal view
        .sheet(isPresented: $showingAddMeal, onDismiss: { self.selectedMeal = nil }) {
            AddMealScreen(viewModel: ApiViewModel())

        }
    }
    
    
    // MealView component - the buttons
    struct MealView: View {
        let mealType: MealType
        var meal: Food?
        var addMealAction: () -> Void
        var showMealDetailsAction: (Food) -> Void
        var dayID: Int
    
        
        var body: some View {
            VStack {
                Text(mealTypeTitle) //B,L,D
                    .foregroundColor(Color.black)
                
                //check if theres a meal in the slot
                if let meal = meal {
                    //has meal
                    Button(action: { showMealDetailsAction(meal) }) {
                        Text(meal.name)
                            .foregroundColor(Color.black)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(CustomTeal.MyTeal)
                    )
                } else {
                    //no meal
                    Button(action: addMealAction) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.black)
                        
                        viewModel.aDay.time =
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(CustomTeal.MyTeal)
                    )
                }
            }
        }
        
        
        
        //displays name of meal slot
        private var mealTypeTitle: String {
            switch mealType {
            case .breakfast:
                return "Breakfast"
            case .lunch:
                return "Lunch"
            case .dinner:
                return "Dinner"
            }
        }
    }
    
    
    
    
    
    
    // AddMealView for adding a new meal
    struct AddMealView: View {
        //    var meal: fakeMeal?
        var body: some View {
            Text("Add a new meal")
        }
    }
    
    
    // MealDetailsView for showing the details of a selected meal
    struct MealDetailsView: View {
        var meal: Food?
        var body: some View {
            if let meal = meal {
                Text("Meal details: \(meal.name), \(meal.calories) calories")
            } else {
                Text("No meal details available")
            }
        }
    }
}
// Preview
struct WeeklyScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyScreen(viewModel: ApiViewModel())
    }
}
