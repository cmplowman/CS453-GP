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

//
//ViewModel
//
class WeeklyScreenViewModel: ObservableObject {
    @Published var week: [Day]
    
    //initializer
    init() {
        week = (0...6).map { Day(id: $0, dayOfWeek: $0, name: WeeklyScreenViewModel.dayName(for: $0)) }
        setupDefaultMeals() //take out when have proper adding
    }
    private static func dayName(for dayOfWeek: Int) -> String {
        ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][dayOfWeek]
    }
    
    //creates example meals for each day/time
    private func setupDefaultMeals() {
        for i in 0..<week.count {
            week[i].breakfast = fakeMeal(name: "Pancakes", calories: 300)
//            week[i].lunch = fakeMeal(name: "Sandwich", calories: 500)
            week[i].dinner = fakeMeal(name: "Pasta", calories: 700)
        }
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
struct Day: Identifiable {
    let id: Int
    let dayOfWeek: Int
    let name: String
    var breakfast: fakeMeal?
    var lunch: fakeMeal?
    var dinner: fakeMeal?
}

//simple meal object
struct fakeMeal: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var calories: Int
}

enum MealType {
    case breakfast, lunch, dinner
}





//
//View
//
//Week Screen
struct WeeklyScreen: View {
    @ObservedObject var viewModel: WeeklyScreenViewModel
    @State private var showingAddMeal = false
    @State private var showingMealDetails = false
    @State private var selectedMeal: fakeMeal?
    
    var body: some View {
        VStack {
            Text("Week").font(.largeTitle)
            //loops through each day in the week
            List(viewModel.week) { day in
                VStack(alignment: .leading) {
                    Text(day.name).font(.title)
                        .foregroundColor(CustomTeal.MyTeal)
                    
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
            //            AddMealScreen(viewModel: ApiViewModel(), pickerSelection: testMeal(name: "Candy", id: 9, calories: 700), favoriteSelection: testMeal(name: "Candy", id: 9, calories: 700))
            //                }
            //updates the meal being passed each time the current time is changed
            //        .onChange(of: selectedMeal) { _ in
            //                    self.showingMealDetails = (self.selectedMeal != nil)
            //                }
        }
    }
    
    
    // MealView component - the buttons
    struct MealView: View {
        let mealType: MealType
        var meal: fakeMeal?
        var addMealAction: () -> Void
        var showMealDetailsAction: (fakeMeal) -> Void
        
        var body: some View {
            VStack {
                Text(mealTypeTitle) //B,L,D
                    .foregroundColor(CustomTeal.MyTeal)
                
                //check if theres a meal in the slot
                if let meal = meal {
                    //has meal
                    Button(action: { showMealDetailsAction(meal) }) {
                        Text(meal.name)
                            .foregroundColor(CustomTeal.MyTeal)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(CustomGrey.MyGrey.opacity(0.6))
                    )
                } else {
                    //no meal
                    Button(action: addMealAction) {
                        Image(systemName: "plus")
                            .foregroundColor(CustomTeal.MyTeal)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(CustomGrey.MyGrey.opacity(0.6))
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
        var meal: fakeMeal?
        var body: some View {
            if let meal = meal {
                Text("Meal details: \(meal.name), \(meal.calories) calories")
            } else {
                Text("No meal details available")
            }
        }
    }
    
    // Preview
    struct WeeklyScreen_Previews: PreviewProvider {
        static var previews: some View {
            WeeklyScreen(viewModel: WeeklyScreenViewModel())
        }
    }
}
