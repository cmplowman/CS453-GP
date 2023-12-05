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
        week = (0...6).map { Day(id: $0, dayOfWeek: $0, name: WeeklyScreenViewModel.dayName(for: $0)) }
    }
    private static func dayName(for dayOfWeek: Int) -> String {
        ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][dayOfWeek]
    }
//    private static func setDayOfWeek(week : [Day]){
//        ForEach(week) { day in
//            switch(day.MealType){
//            case .breakfast: day.time = 1
//            case .lunch: day.time = 2
//            case .dinner: day.time = 3
//            }
//            print(day.time)
//        }
//    }
    
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
//enum MealType {
//    case breakfast, lunch, dinner
//}





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
    
    @State var week: [WeeklyScreen.MealView]

        init(viewModel: ApiViewModel) {
            self.viewModel = viewModel
            self._week = State(initialValue: (0...6).map { dayIndex in
                WeeklyScreen.MealView(
                    viewModel: viewModel,
                    dayID: dayIndex,
                    mealTime: 1, // or appropriate value for mealTime
                    mealType: .breakfast, // or .lunch, .dinner based on your need
                    meal: nil, // or appropriate Food object
                    addMealAction: {
                        // Define action for adding a meal
                    },
                    showMealDetailsAction: { food in
                        // Define action for showing meal details
                    }
                )
            })
        }

    
    var body: some View {
        VStack {
            Text("Week").font(.largeTitle)
            //loops through each day in the week
            List(viewModel.weekDay) { day in
                VStack(alignment: .leading) {
                    Text(day.name).font(.title)
                        .foregroundColor(Color.black)
                    
                    //Day
                    HStack {
                        //breakfast
                        MealView(viewModel: viewModel, dayID: day.dayOfWeek, mealTime: 1, mealType: .breakfast, meal: day.breakfast,
                                 addMealAction: { self.showingAddMeal = true },
                                 showMealDetailsAction: { meal in
                            self.selectedMeal = meal
                            self.showingMealDetails = true
                        })
                        //lunch
                        MealView(viewModel: viewModel, dayID: day.dayOfWeek, mealTime: 2, mealType: .lunch, meal: day.lunch,
                                 addMealAction: { self.showingAddMeal = true },
                                 showMealDetailsAction: { meal in
                            self.selectedMeal = meal
                            self.showingMealDetails = true
                        })
                        //dinner
                        MealView(viewModel: viewModel, dayID: day.dayOfWeek, mealTime: 3, mealType: .dinner, meal: day.dinner,
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
                MealDetailsView(meal: meal, viewModel: viewModel)
            }
        }
        //opens add meal view
        .sheet(isPresented: $showingAddMeal, onDismiss: { self.selectedMeal = nil }) {
            AddMealScreen(viewModel: viewModel, showingAddMeal: $showingAddMeal)

        }
    }
    //, showingAddMeal: $showingAddMeal, plsStop: $plsStop, currentDayID: $currentDayID, currentMealSlot: $currentMealSlot
    
    
    // MealView component - the buttons
    struct MealView: View  {
        @ObservedObject var viewModel: ApiViewModel
        var dayID: Int
        var mealTime: Int
        let mealType: MealType
        var meal: Food?
        var addMealAction: () -> Void
        var showMealDetailsAction: (Food) -> Void
        
       // var dayID: Int
    
        
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
                                            viewModel.time = mealTime
                                            viewModel.dayOfWeek = dayID
                                            print("mealtime: \(mealTime)")
                                            print("VMtime: \(viewModel.time)")
                                            print("dayID: \(dayID)")
                                            print("VMDOW: \(viewModel.dayOfWeek)")
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
                        
                       // viewModel.aDay.time =
                        
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
        @ObservedObject var viewModel: ApiViewModel
        var body: some View {
//            if let meal = meal {
//                Text("Meal details: \(meal.name), \(meal.calories) calories")
//            } else {
//                Text("No meal details available")
//            }
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
    }
}
// Preview
struct WeeklyScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyScreen(viewModel: ApiViewModel())
    }
}
