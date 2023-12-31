//
//  Home Screen.swift
//  TEST
//
//  Created by Callie on 10/31/23.
//

import SwiftUI
import UIKit

struct HomeContentView: View {
    @State private var swipeOffset: CGFloat = 0
    @State private var showingSheet = false
    @State var StatSheetShowing = false
//    @State var favoritesList: [Meal] = [
//        Meal(name: "Meal 1", id: 1),
//        Meal(name: "Meal 2", id: 2),
//        Meal(name: "Meal 3", id: 3)]
    @State var goalShowingSheet = false

    var body: some View {
        NavigationView{
            ZStack{
                CustomGrey.MyGrey
                    .ignoresSafeArea(edges: .bottom)
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                    .foregroundStyle(CustomGrey.MyGrey)
                CustomTeal.MyTeal
                    .ignoresSafeArea(edges: .top)
                VStack{
                    
                    
                    favorites(showingSheet: $showingSheet, goalShowingSheet: $goalShowingSheet)
                        .padding(.vertical)
                        .padding(.vertical)
                    BLDView()
        
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        VStack {
                            RoundedRectangle(cornerSize: CGSize(width: 200, height: 10))
                                .frame(width: 100, height: 23)
                                .foregroundStyle(CustomGrey.MyGrey)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            swipeOffset = value.translation.height
                                        }
                                        .onEnded { value in
                                            if swipeOffset < -50 {
                                                // Swipe-up gesture detected
                                                StatSheetShowing.toggle()
                                            }
                                            swipeOffset = 0
                                        }
                                )
                                .sheet(isPresented: $StatSheetShowing) {
                                    StatSheet(viewModel: ApiViewModel())
                                        .background(Color.gray)
                                }
                            Rectangle()
                                .frame(width: 60, height: 8)
                                .foregroundColor(.gray)
                                .cornerRadius(5)
                        }
                    }
                }
            }
        }
    }
}
struct goalsView: View {
    @Binding var goalShowingSheet: Bool
    var body: some View {
        VStack{
            HStack{
                Spacer()
                    .padding(.all)
                Button("X")
                {
                    goalShowingSheet.toggle()
                }
                .foregroundStyle(Color.gray)
                .font(.system(size: 20))
            }
            Text("Meal Statistics")
                .font(.system(size: 35))
        }
    }
}
struct swipeView: View
{
    @State private var isViewVisible = false
    @State var StatSheetShowing = false
    var body: some View{
        ZStack{
            if isViewVisible{
                WeeklyScreen(viewModel: ApiViewModel())
                

            }
            else{
                HomeContentView()
            }
            
        }
        Button("+")
        {
            isViewVisible = true
        }
        /*
        .gesture(
            DragGesture()
                .onChanged { value in
                    swipeOffset = value.translation.height
                }
                .onEnded { value in
                    if value.translation.width < -50 {
                        isViewVisible = false
                    }
                    else
                    {
                        isViewVisible = true
                    }
                    swipeOffset = 0
                    
                }
        )
        .animation(.default, value: isViewVisible)
         */
    }
    
}

struct favorites: View {
    @Binding var showingSheet: Bool
//    @Binding var favoritesList: [Meal]
    @Binding var goalShowingSheet: Bool
    var body: some View {
        VStack{
            HStack{
                
                Text("Daily Dish")
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.vertical)
                    .font(.system(size: 35))
                    .foregroundStyle(.white)
                Image(.star2)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.leading)
                    .padding(.leading)
                    
                    .onTapGesture {
                        showingSheet = true
                    }
                    .foregroundColor(CustomTeal.MyTeal)
                    .sheet(isPresented: $showingSheet) {
                        FavoritesView(showingSheet: $showingSheet, viewModel: ApiViewModel())
                    }
     
            }
        }
    }
}

struct BLDView : View
{
    var body: some View{
        VStack {
                let today = Date()
                let getDate = today.currentDate()
                Text("\(getDate)")
                    .font(.system(size: 28))
                    .foregroundStyle(Color.white)
            Spacer()
            .padding(.top)
            HStack{
                NavigationLink("weekly screen", destination: WeeklyScreen(viewModel: ApiViewModel()))
            }
            ZStack{
                RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                
                    .frame(width: 300, height: 120)
                    .foregroundColor(CustomGrey.MyGrey)
                    .padding(.bottom)
                Text("Breakfast")
                    .padding(.bottom)
                    .foregroundStyle(Color.white)
                //.onTapGesture {
                //to modal sheet for breakfast
                //}
            }
            ZStack{
                RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                    .frame(width: 300, height: 120)
                    .foregroundColor(CustomGrey.MyGrey)
                    .padding(.vertical)
                    .padding(.bottom)
                Text("Lunch")
                    .padding(.bottom)
                    .foregroundStyle(Color.white)
                //.onTapGesture {
                //to modal sheet for lunch
                //}
            }
            ZStack{
                RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                    .frame(width: 300, height: 120)
                    .foregroundColor(CustomGrey.MyGrey)
                Text("Dinner")
                    .foregroundStyle(Color.white)
                //.onTapGesture {
                //to modal sheet for dinner
                //}
            }
        }
        Spacer()
            .padding()
    }
    
}
extension Color{
    struct myTeal{
        static let thisTeal = Color("softTeal")
    }
}

extension Image {
    struct myStar {
        static let star = Image("star2")
    }
}

extension Date{
    func currentDate() -> String{
        let dateForm = DateFormatter()
        dateForm.dateFormat = "EEEE, MMMM d"
        return dateForm.string(from: self)
    }
    func updateGoals(d: Day, goals: Int) -> Bool
    {
        let dateForm = DateFormatter()
        dateForm.dateFormat = ""
        let cal = Calendar.current
        let components = cal.dateComponents([.day, .hour, .minute, .second], from: Date())
        
        if let hour = components.hour, let minutues = components.minute, let seconds = components.second
        {
            if hour == 0  && minutues == 0 && seconds == 0 //
            {
                return true
            }
        }
        return false
    }
    
}


struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        swipeView()
    }
}
