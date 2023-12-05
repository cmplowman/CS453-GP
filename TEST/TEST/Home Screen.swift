//
//  Home Screen.swift
//  TEST
//
//  Created by Callie on 10/31/23.
//

import SwiftUI

struct HomeContentView: View {
    @State private var swipeOffset: CGFloat = 0
    @State private var showingSheet = false
    @State var StatSheetShowing = false
    @State var favoritesList: [Meal] = [
        Meal(name: "Meal 1", id: 1),
        Meal(name: "Meal 2", id: 2),
        Meal(name: "Meal 3", id: 3)]
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
                    favorites(showingSheet: $showingSheet, favoritesList: $favoritesList, goalShowingSheet: <#Binding<Bool>#>)
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
                                    StatSheet()
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
    var body: some View{
        ZStack{
            if isViewVisible{
                WeeklyScreen(viewModel: WeeklyScreenViewModel())
                

            }
            else{
                HomeContentView()
            }
            
        }
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.width < -50 {
                        isViewVisible = false
                    }
                    else
                    {
                        isViewVisible = true
                    }
                }
            )
        .animation(.default, value: isViewVisible)
    }
    
}

struct favorites: View {
    @Binding var showingSheet: Bool
    @Binding var favoritesList: [Meal]
    @Binding var goalShowingSheet: Bool
    var body: some View {
        VStack{
            HStack{
                Button("G")
                {
                    goalShowingSheet.toggle()
                }
                .padding(.trailing)
                .padding(.trailing)
                .padding(.trailing)
                .font(.system(size: 20))
                 


                Text("Meal Tracker")
                    //.padding(.leading)
                    //.padding(.leading)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.trailing)
                    .padding(.trailing)
                    .padding(.trailing)

                    .padding(.vertical)
                    .font(.system(size: 35))
                    .foregroundStyle(.white)
                
                Text("Meal Tracker")
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.vertical)
                    .font(.system(size: 35))
                    .foregroundStyle(.white)
//                Image(.star)
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .padding(.leading)
//                    .padding(.leading)
                    
                    .onTapGesture {
                        showingSheet = true
                    }
                    .foregroundColor(CustomTeal.MyTeal)
                    .sheet(isPresented: $showingSheet) {
                        FavoritesView(showingSheet: $showingSheet, favoritesList: $favoritesList)
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
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                    .font(.system(size: 28))
                    .foregroundStyle(Color.white)
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








