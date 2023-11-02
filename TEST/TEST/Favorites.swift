//
//  Favorites.swift
//  TEST
//
//  Created by Student on 10/31/23.
//

import SwiftUI
//list of fav meals with macros the user has entered
//ability to remove favortites from the screen
struct temp: View {
    @State var showingSheet = false
    //@State var selectedPost: Meal?
    /* @Published*/ @State var favoritesList: [Meal] = [
        Meal(name: "Meal 1", id: 1),
        Meal(name: "Meal 2", id: 2),
        Meal(name: "Meal 3", id: 3)]
             
    var body: some View {
        VStack {
            Text("< Favorites Button >")
                .onTapGesture {
                    //selectedMeal = Meal
                    showingSheet = true
                }
                .foregroundColor(CustomTeal.MyTeal)
                .sheet(isPresented: $showingSheet) {
                    FavoritesView(showingSheet: $showingSheet, favoritesList: $favoritesList /*, selectedMeal: $selectedPost*/)
            }
        }
    }
}

struct FavoritesView: View {
    @Binding var showingSheet: Bool
    @Binding var favoritesList: [Meal]
    //@Binding var selectedMeal: Meal?
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Spacer()
                Text("Favorites")
                    .padding()
                    .foregroundColor(CustomTeal.MyTeal)
                    .font(.system(size:30))
                
                Spacer()
                
                Button("X") {
                    showingSheet = false
                }
                .foregroundColor(Color.black)
                .font(.system(size:25))
                .padding()
            }
            .background(Color.white)
            
            Divider()
                .frame(width:340, height: 2)
                .overlay(CustomTeal.MyTeal)
            
            List {
                ForEach(favoritesList, id: \.id) { Meal in
                    HStack {
                        Text("\(Meal.name)")
                            .foregroundColor(CustomTeal.MyTeal)
                            .onTapGesture {
                                print("tapped on Meal \(Meal.id)")
                        }
                            
                        Spacer()
                            
                        Text("-")
                            .font(.system(size:20))
                            .foregroundColor(CustomTeal.MyTeal)
                            .onTapGesture {
                                if let index = favoritesList.firstIndex(where: { $0.id == Meal.id }) {
                                    favoritesList.remove(at: index)
                                }
                            }
                    }
                    .listRowBackground(CustomGrey.MyGrey)
                    .listRowSeparatorTint(Color.white)
                }
            }
        }
        .listRowBackground(CustomGrey.MyGrey)
        .scrollContentBackground(.hidden)
    }
}




struct CustomTeal {
    static let MyTeal = Color("Teal")
}

struct CustomGrey {
    static let MyGrey = Color("Grey")
}

struct Meal: Codable, Identifiable {
    let name: String
    let id: Int
}

struct temp_Previews: PreviewProvider {
    static var previews: some View {
        temp()
    }
}
