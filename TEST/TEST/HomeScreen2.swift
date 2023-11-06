//
//  Home Screen.swift
//  TEST
//
//  Created by Callie on 10/31/23.
//

import SwiftUI

//
//CHANGES again
struct HomeContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.mint
                    .ignoresSafeArea(edges: .top)
                VStack{
                    favorites()
                        .padding(.vertical)
                        .padding(.vertical)
                    BLDView()
                }
                .toolbar{
                    //Color.CustomGrey.MyGrey
                    ToolbarItem(placement: .bottomBar){
                        
                        VStack{
                            
                            Button("---") //temporary
                            {
                                //pop up nutritional values
                                //
                            }
                            HStack{
                                //Image version of toolbar
                                /*
                                Image(.plateAndUtensilsTopView)
                                    .resizable()
                                    .frame(width: 30, height: 30)//calories
                                Image(.avacado)
                                    .resizable()
                                    .frame(width: 30, height: 30) //fats
                                Image(.salt1)
                                    .resizable()
                                    .frame(width: 30, height: 30) //sodium
                                Image(.steak)
                                    .resizable()
                                    .frame(width: 30, height: 30) //protein
                                Image(.pasta)
                                    .resizable()
                                    .frame(width: 30, height: 30) //carbs
                                Image(.sugar)
                                    .resizable()
                                    .frame(width: 30, height: 30) //sugar
                                */
                                
                                //Dots version of toolbar
                                /*
                                Image(.calorieIcon)
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                
                                Image(.proteinsIcon)
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                Image(.carbsIcon)
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                Image(.sugarIcon)
                                    .resizable()
                                    .frame(width: 70, height: 100)
                                //sugar
                                */
                                 //Text version of toolbar
                                
                                 Text("Cal:")
                                    .padding(.horizontal)
                                

                                 Text("Protein:")
                                    .padding(.horizontal)


                                 Text("Carbs:")
                                    .padding(.horizontal)



                                 Text("Sugar:")
                                    .padding(.horizontal)
                                 //Spacer()

                                 
                                
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

struct favorites: View {
    var body: some View {
        VStack{
            //title()
            HStack{
                
                Text("Meal Tracker")
                    //.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.vertical)
                    .font(.system(size: 35))
                    .foregroundStyle(.white)
                //let myFavorites = FavoritesView(showingSheet:, favoritesList: )
                /*Image(.star2)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.leading)
                    .padding(.leading)
                    
                    .onTapGesture {
                        
                    }
                 */
                
                //Spacer()
            }
            //Spacer()
        }
        
            
    }
}
/*
struct title: View{
    var body: some View{
        v{
             //change when we figure out App name
        }
        .navigationTitle("Meal Tracker")
    }
    
}
 */
struct BLDView : View
{
    var body: some View{
        
        
        //probably will pull from a list of todays meals
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
                    .foregroundColor(CustomGrey.MyGrey)//change to cutstom color
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
                    .foregroundColor(CustomGrey.MyGrey)//change to cutstom color
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
                    .foregroundColor(CustomGrey.MyGrey)//change to cutstom color
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
//next step: get this function to only print month and day.
// -- this func isnt working currently, it's formatted in this style in BLDView
extension Date{
    func currentDate() -> String{
        //let current = Date()
        let dateForm = DateFormatter()
        //dateForm.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        //if let date = dateForm.date(from: currentDate){
          //  let myDateFormat = DateFormatter()
        dateForm.dateFormat = "EEEE, MMMM d"
        return dateForm.string(from: self)
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
        temp()
    }
}

//Favorites tab -- star, will have functionality - modal sheet
//APP Title
//Breakfast area - rounded rectangle
//Lunch area - rounded recctangle
//Dinner area - rounded rectangle
//nutrititonal bar area


