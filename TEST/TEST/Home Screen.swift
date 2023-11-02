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
        
        VStack{
            favorites()
            Spacer()
                .padding(.vertical)
            BLDView()
    
        }
            
        
    
    }
}
struct favorites: View {
    var body: some View {
        VStack{
            //title()
            HStack{
                
                Text("Meal Tracker")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.leading)
                Image(systemName: "star")
                    .imageScale(.large)
                    .foregroundColor(.yellow)
                    .padding(.leading)
                    .padding(.leading)
                
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
           
            Text("Todays Date")
            RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 100)
                .foregroundColor(.gray)//change to cutstom color
            RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 100)
                .foregroundColor(.gray)//change to cutstom color
            RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 100)
                .foregroundColor(.gray)//change to cutstom color
        }
        Spacer()
        .padding()
    }
    
}
struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
//Favorites tab -- star, will have functionality - modal sheet
//APP Title
//Breakfast area - rounded rectangle
//Lunch area - rounded recctangle
//Dinner area - rounded rectangle
//nutrititonal bar area
