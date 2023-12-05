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

//
//ViewModel
//
class WeeklyScreenViewModel: ObservableObject {
    @Published var week: [Day]
    
    //initializer
    init() {
        week = (0...6).map { Day(id: $0, dayOfWeek: $0, name: WeeklyScreenViewModel.dayName(for: $0)) } //take out when have proper adding
    }
    private static func dayName(for dayOfWeek: Int) -> String {
        ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][dayOfWeek]
    }
    
    //
//    func updateMeal(for dayOfWeek: Int, meal: fakeMeal, type: MealType) {
//        if let index = week.firstIndex(where: { $0.dayOfWeek == dayOfWeek }) {
//            switch type {
//            case .breakfast:
//                week[index].breakfast = meal
//            case .lunch:
//                week[index].lunch = meal
//            case .dinner:
//                week[index].dinner = meal
//            }
//            self.objectWillChange.send()
//        }
//    }
}




//
// Model
//
//day object - contians day and 3 meal slots
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
    @State private var plsStop = true
    @State private var selectedMeal: Food?
    @State private var currentDayID = 0
    @State private var currentMealSlot: MealType = .breakfast
    
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
                        MealView(viewModel: viewModel, plsStop: $plsStop, dayID: day.dayOfWeek, mealType: .breakfast, meal: day.breakfast,
                                 addMealAction: { self.showingAddMeal = true },
                                 showMealDetailsAction: { meal in
                            self.selectedMeal = meal
                            self.showingMealDetails = true
                        })
                        //lunch
                        MealView(viewModel: viewModel, plsStop: $plsStop, dayID: day.dayOfWeek, mealType: .lunch, meal: day.lunch,
                                 addMealAction: { self.showingAddMeal = true },
                                 showMealDetailsAction: { meal in
                            self.selectedMeal = meal
                            self.showingMealDetails = true
                        })
                        //dinner
                        MealView(viewModel: viewModel, plsStop: $plsStop, dayID: day.dayOfWeek, mealType: .lunch, meal: day.dinner,
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
            AddMealScreen(viewModel: ApiViewModel(), showingAddMeal: $showingAddMeal, plsStop: $plsStop, currentDayID: $currentDayID, currentMealSlot: $currentMealSlot)

        }
    }
    
    
    // MealView component - the buttons
    struct MealView: View {
        @ObservedObject var viewModel: ApiViewModel
        @Binding var plsStop: Bool
        var dayID: Int
        let mealType: MealType
        var meal: Food?
        var addMealAction: () -> Void
        var showMealDetailsAction: (Food) -> Void
        
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
                    //                    Button(action: addMealAction) {
                    //                        Image(systemName: "plus")
                    //                            .foregroundColor(Color.black)
                    //                        viewModel.updateMeal(forDayID: dayID, mealType: mealType, withMeal: viewModel.selectedMeal)
                    //                    }
                    //                    .buttonStyle(PlainButtonStyle())
                    //                    .padding()
                    //                    .background(
                    //                        RoundedRectangle(cornerRadius: 5)
                    //                            .fill(CustomTeal.MyTeal)
                    //                    )
                                        Button(action: {
                                            // First, perform the addMealAction, if it has additional functionality.
                                            print("pressed add button")
                                            addMealAction()
                                            print("meal action over")
                    //                        while(plsStop==true){
                    //                            if(plsStop==false){
                    //                                if let selectedMeal = viewModel.selectedMeal {
                    //                                    viewModel.updateMeal(forDayID: dayID, mealType: mealType, withMeal: selectedMeal)
                    //                                }
                    //                            }
                    //                        }
                    //                        print("back from add screen")
                    //                        // Then, update the meal in the viewModel.
                    //                        if let selectedMeal = viewModel.selectedMeal {
                    //                            viewModel.updateMeal(forDayID: dayID, mealType: mealType, withMeal: selectedMeal)
                    //                        }
                    //                        print("back from update meal")
                                        }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.black)
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
