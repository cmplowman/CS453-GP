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
            
        }
        .padding()
    }
}

//ViewModel
class WeeklyScreenViewModel: ObservableObject{
    @Published var week: [Day] = []
    
    //add meals & stuff in here
    
    //create each day object
    let monday = Day(dayOfWeek: 1)
    
}

//Model
struct Day {
    let dayOfWeek: Int //0=sun, 1=mon, ... 6=sat
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
        WeeklyScreen()
    }
}
