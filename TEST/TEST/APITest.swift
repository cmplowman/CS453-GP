//
//  APITest.swift
//  TEST
//
//  Created by Student on 12/3/23.
//

import SwiftUI

struct APIView: View {
@State var foods = [Food]()
@State var query: String = ""
var body: some View {
    LinearGradient(gradient: Gradient(colors: [CustomTeal.MyTeal, Color.gray]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.vertical)
        .overlay(
            VStack(alignment: .leading) {
                VStack {
                    TextField(
                        "Enter some food text",
                        text: $query
                    )
                    .multilineTextAlignment(.center)
                    .font(Font.title.weight(.light))
                    .foregroundColor(Color.white)
                    .padding()
                    HStack {
                        Spacer()
                        Button(action: getNutrition) {
                            Text("Get Nutrition")
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                        .font(.title2)
                        .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .padding(30.0)
                List {
                    ForEach(foods) { food in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(food.name)")
                                    .font(.title)
                                    .padding(.bottom)
                                Text("Serving Size: \(String(format: "%.1f", food.calories)) calories")
                                    .font(.title2)
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
        )
    }
    func getNutrition() {
            print("\(query) in getNutrition")
            ApiViewModel().loadData(query: self.query) { foods in
                self.foods = foods
            }
    }
}

struct APIView_Previews: PreviewProvider {
    static var previews: some View {
        APIView()
    }
}
