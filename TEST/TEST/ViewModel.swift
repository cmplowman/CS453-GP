//  ViewModel.swift
//  TEST
//
//  Created by Chris Plowman on 12/3/23.


import Foundation

struct Food: Codable, Identifiable {
    var id = UUID()
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

//day object - contians day and 3 meal slots
struct Day: Codable, Identifiable {
    var id: Int
    var dayOfWeek: Int
    var name: String
    var breakfast: Food?
    var lunch: Food?
    var dinner: Food?
}


class ApiViewModel: ObservableObject {
    @Published var foods = [Food]()
    @Published var query: String = ""

    @Published var week: [Day]
    
    @Published var weeklyCals = 12.0
    @Published var weeklyFats = 13.0
    @Published var weeklyProtein = 14.03
    @Published var weeklySodium = 15.50
    @Published var weeklyCholest = 16.60
    @Published var weeklyCarbs = 25.0
    @Published var weeklySugars = 99.0

    @Published var goalCals = 24.01
    @Published var goalFats = 14.02
    @Published var goalProtein = 14.03
    @Published var goalSodium = 14.04
    @Published var goalCholest = 18.05
    @Published var goalCarbs = 50.06
    @Published var goalSugars = 120.07
    
    @Published var favoritesList: [Food] //Connects to list in favorites
    @Published var weekDay: [Day] //Connects Weekly Screen list
    
    private let thisFood: String = "food"
    private let fav: String = "favorites"
    private let thisDay: String = "today"

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
    
    //initializer
    init() {
        
        if let favorite = UserDefaults.standard.getCodable([Food].self, forKey: fav) {
            favoritesList = favorite
        } else {
            favoritesList = []
        }
        if let myFood = UserDefaults.standard.getCodable([Food].self, forKey: thisFood) {
            foods = myFood
        } else {
            foods = []
        }
        if let myDay = UserDefaults.standard.getCodable([Day].self, forKey: thisDay) {
            weekDay = myDay
        } else {
            weekDay = []
        }
        
        week = (0...6).map { Day(id: $0, dayOfWeek: $0, name: ApiViewModel.dayName(for: $0)) }
        setupDefaultMeals() //take out when have proper adding
    }
    static func dayName(for dayOfWeek: Int) -> String {
        ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][dayOfWeek]
    }
    
    //creates example meals for each day/time
    func setupDefaultMeals() {
        for i in 0..<week.count {
 //           week[i].breakfast = fakeMeal(name: "Pancakes", calories: 300)
//            week[i].lunch = fakeMeal(name: "Sandwich", calories: 500)
//            week[i].dinner = fakeMeal(name: "Pasta", calories: 700)
        }
    }

    func getNutrition(query: String) {
        ApiViewModel().loadData(query: self.query) { foods in
            print("\(query) in getNutrition")
            self.foods = foods
        }
    }
    
    func combineFoods() -> Food
        {
            var fullMeal = Food(name: "", calories: 0.0, serving_size_g: 0.0, fat_total_g: 0.0, fat_saturated_g: 0.0, protein_g: 0.0, sodium_mg: 0.0, potassium_mg: 0.0, cholesterol_mg: 0.0, carbohydrates_total_g: 0.0, fiber_g: 0.0, sugar_g: 0.0)
            for f in foods {
                fullMeal.name += f.name + " "
                fullMeal.calories += f.calories
                fullMeal.carbohydrates_total_g += f.carbohydrates_total_g
                fullMeal.protein_g += f.protein_g
                fullMeal.sugar_g += f.sugar_g
                fullMeal.fat_total_g += f.fat_total_g
                fullMeal.sodium_mg += f.sodium_mg
                fullMeal.cholesterol_mg += f.cholesterol_mg
            }
            return fullMeal
        }


    func addFavorite(f: Food) //should change if testMeal changes
        {
            let newMeal = combineFoods()
            favoritesList.append(newMeal)
            saveFavorite() //updates task list
        }
        /*
           removes meal from week list.
        */
        func removeMeal(at offsets: IndexSet)
        {
           foods.remove(atOffsets: offsets)
           saveMeal() //updates task list
        }
        /*
           updates favorite meals
         */
        func saveFavorite() //save meal for the week ....if there is a list for meals of the week, the key should be changed to the list
        {
           do{
               try UserDefaults.standard.setCodable(favoritesList, forKey: fav)
           }catch{
               print("error favoriting this meal")
           }
        }
       /*
           updates weekly meals
        */
    
       func saveMeal() //may not need
       {
           do{
               try UserDefaults.standard.setCodable(weekDay, forKey: thisDay)
           }catch{
               print("error saving this meal")
           }
       }
       /*
           saves day of the week object
        */
       func saveWeek()
       {
           do{
               try UserDefaults.standard.setCodable(weekDay, forKey: thisDay)
           }catch{
               print("error saving this meal")
           }
    
       }
}
public extension UserDefaults {

   func setCodable<T: Codable>(_ object: T, forKey: String) throws {
       let jsonData: Data = try JSONEncoder().encode(object)
       set(jsonData, forKey: forKey)
   }

   func getCodable<T: Codable>(_ ot: T.Type, forKey: String) -> T? {
       guard let result = value(forKey: forKey) as? Data else { return nil }
       return try? JSONDecoder().decode(ot, from: result)
   }
}

//private let thisFood: String = "food"
//    private let fav: String = "favorites"
//    private let thisDay: String = "today"
//    @Published var foods = [Food]()
//    @Published var query: String = ""
//    @Published var favoritesList: [Food] //Connects to list in favorites
//    @Published var weekDay: [Day] //Connects Weekly Screen list
//    init(){
//        if let favorite = UserDefaults.standard.getCodable([Food].self, forKey: fav) {
//             favoritesList = favorite
//        } else {
//            favoritesList = []
//        }
//        if let myFood = UserDefaults.standard.getCodable([Food].self, forKey: thisFood) {
//             foods = myFood
//        } else {
//            foods = []
//        }
//        if let myDay = UserDefaults.standard.getCodable([Day].self, forKey: thisDay) {
//             weekDay = myDay
//        } else {
//            weekDay = []
//        }
//
//    }
//
//    func combineFoods() -> Food
//    {
//        var fullMeal = Food(name: "", calories: 0.0, serving_size_g: 0.0, fat_total_g: 0.0, fat_saturated_g: 0.0, protein_g: 0.0, sodium_mg: 0.0, potassium_mg: 0.0, cholesterol_mg: 0.0, carbohydrates_total_g: 0.0, fiber_g: 0.0, sugar_g: 0.0)
//        for f in foods {
//            fullMeal.name += f.name + " "
//            fullMeal.calories += f.calories
//            fullMeal.carbohydrates_total_g += f.carbohydrates_total_g
//            fullMeal.protein_g += f.protein_g
//            fullMeal.sugar_g += f.sugar_g
//            fullMeal.fat_total_g += f.fat_total_g
//            fullMeal.sodium_mg += f.sodium_mg
//            fullMeal.cholesterol_mg += f.cholesterol_mg
//        }
//        return fullMeal
//    }


//func addFavorite(f: Food) //should change if testMeal changes
//    {
//        let newMeal = combineFoods()
//        favoritesList.append(newMeal)
//        saveFavorite() //updates task list
//    }
//    /*
//       removes meal from week list.
//    */
//    func removeMeal(at offsets: IndexSet)
//    {
//       foods.remove(atOffsets: offsets)
//       saveMeal() //updates task list
//    }
//    /*
//       updates favorite meals
//     */
//    func saveFavorite() //save meal for the week ....if there is a list for meals of the week, the key should be changed to the list
//    {
//       do{
//           try UserDefaults.standard.setCodable(favoritesList, forKey: fav)
//       }catch{
//           print("error favoriting this meal")
//       }
//    }
//   /*
//       updates weekly meals
//    */
//
//   func saveMeal() //may not need
//   {
//       do{
//           try UserDefaults.standard.setCodable(weekDay, forKey: thisDay)
//       }catch{
//           print("error saving this meal")
//       }
//   }
//   /*
//       saves day of the week object
//    */
//   func saveWeek()
//   {
//       do{
//           try UserDefaults.standard.setCodable(weekDay, forKey: thisDay)
//       }catch{
//           print("error saving this meal")
//       }
//
//   }
//
//}
//public extension UserDefaults {
//
//   func setCodable<T: Codable>(_ object: T, forKey: String) throws {
//       let jsonData: Data = try JSONEncoder().encode(object)
//       set(jsonData, forKey: forKey)
//   }
//
//   func getCodable<T: Codable>(_ ot: T.Type, forKey: String) -> T? {
//       guard let result = value(forKey: forKey) as? Data else { return nil }
//       return try? JSONDecoder().decode(ot, from: result)
//   }
//}
