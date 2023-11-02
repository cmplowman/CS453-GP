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

//View
struct WeeklyScreen: View {
    @ObservedObject var viewModel: WeeklyScreenViewModel
//    @State var
    var body: some View {
        VStack {
            HStack{
                Text("Week")
                    .font(.largeTitle)
            }
            Spacer()
            //will be a list week (a the day list from VM)
            //have Text for day of week (sun, mon, etc.)
            //each entry from list wil display the day.breakfast, etc
            List {
                ForEach(viewModel.week, id: \.dayOfWeek) {day in
                    VStack{
                        HStack{
                            //Text("\(day.dayOfWeek)")
                            Text("\(day.name)")
                                .font(.title)
                            Spacer()
                        }
                        HStack{
                            Button("B"){
                                mealButton()
                            }
                            Spacer()
                            Button("L"){
                                mealButton()
                            }
                            Spacer()
                            Button("D"){
                                mealButton()
                            }
                            Spacer()
                        }
                    }
                }
            }
            
        }
        .padding()
    }
    func mealButton() {
        //if ... open this or open that
    }
}




//ViewModel
class WeeklyScreenViewModel: ObservableObject{
    @Published var week: [Day] = [
        Day(dayOfWeek: 0, name: "Sunday"),
        Day(dayOfWeek: 1, name: "Monday"),
        Day(dayOfWeek: 2, name: "Tuesday"),
        Day(dayOfWeek: 3, name: "Wednesday"),
        Day(dayOfWeek: 4, name: "Thursday"),
        Day(dayOfWeek: 5, name: "Friday"),
        Day(dayOfWeek: 6, name: "Saturday")
    ]
    
    //add meals & stuff in here
    
    //create each day object
//    let monday = Day(dayOfWeek: 1)
    
//    func addDays (){
//        week.append(monday: Day)
//    }
    
}

//Model
struct Day {
    let dayOfWeek: Int //0=sun, 1=mon, ... 6=sat
    let name: String
//    let month: Int
//    let dayOfMonth: Int
//    let year: Int
//    let breakfast: Meal
//    let lunch: Meal
//    let dinner: Meal
//    let totalCal: Int
}

struct WeeklyScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyScreen(viewModel: WeeklyScreenViewModel())
    }
}
