//
//  ViewModel.swift
//  TEST
//
//  Created by Student on 12/3/23.
//

import Foundation

struct Food: Codable, Identifiable {
    let id = UUID()
    var name: String
    var calories: Double
    var serving_size_g: Double
    var fat_total_g: Double
    var fat_saturated_g: Double
    var protein_g: Double
    var sodium_mg: Double
    var potassium_mg: Double
    var cholesterol_mg: Double
    var carbohydrates_total_g: Double
    var fiber_g: Double
    var sugar_g: Double
}

class ApiViewModel: ObservableObject {
    @Published var foods = [Food]()
    @Published var query: String = ""

    func loadData(query: String, completion: @escaping ([Food]) -> ()) {
        print("\(query)")
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=" + encodedQuery) else {
            print("Invalid UR req")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("ZBTwuhxSrZwW8HhjDGbGWg==k55Sh4vS5blwagug", forHTTPHeaderField: "X-Api-Key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let foods = try JSONDecoder().decode([Food].self, from: data)
                    print(foods)
                    DispatchQueue.main.async {
                        completion(foods)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    func getNutrition(query: String) {
        ApiViewModel().loadData(query: self.query) { foods in
            print("\(query) in getNutrition")
            self.foods = foods
        }
    }
    
}
