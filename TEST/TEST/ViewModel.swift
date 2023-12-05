//  ViewModel.swift
//  TEST
//
//  Created by Chris Plowman on 12/3/23.


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
    @Published var week: [Day]
    @Published var foods = [Food]()
    @Published var query: String = ""
    
    @Published var weeklyCals = 12.0
    @Published var weeklyFats = 13.0
    @Published var weeklyProtein = 14.03
    @Published var weeklySodium = 15.50
    @Published var weeklyCholest = 16.60
    @Published var weeklyCarbs = 25.0
    @Published var weeklySugars = 99.0

    private let myWeekCals = "weekCals"
    private let myWeekFats = "weekFats"
    private let myWeekProtein = "weekPro"
    private let myWeekSod = "weekSod"
    private let myWeekCholest = "weekCholest"
    private let myWeekCarbs = "weekCarbs"
    private let myWeekSugar = "weekSugar"
    
    @Published var goalCals = 24.01
    @Published var goalFats = 14.02
    @Published var goalProtein = 14.03
    @Published var goalSodium = 14.04
    @Published var goalCholest = 18.05
    @Published var goalCarbs = 50.06
    @Published var goalSugars = 120.07
    
    private let myGoalCals = "goalCals"
    private let myGoalFats = "goalFats"
    private let myGoalProtein = "goalPro"
    private let myGoalSod = "goalSod"
    private let myGoalCholest = "goalCholest"
    private let myGoalCarbs = "goalCarbs"
    private let myGoalSugar = "goalSugar"
    
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
        //current nutrition
        weeklyCals = UserDefaults.standard.double(forKey: myWeekCals)
        weeklyFats = UserDefaults.standard.double(forKey: myWeekFats)
        weeklyProtein = UserDefaults.standard.double(forKey: myWeekProtein)
        weeklySodium = UserDefaults.standard.double(forKey: myWeekSod)
        weeklyCholest = UserDefaults.standard.double(forKey: myWeekCholest)
        weeklyCarbs = UserDefaults.standard.double(forKey: myWeekCarbs)
        weeklySugars = UserDefaults.standard.double(forKey: myWeekSugar)
         
         
        //goals the user want to reach
        goalCals = UserDefaults.standard.double(forKey: myGoalCals)
        goalFats = UserDefaults.standard.double(forKey: myGoalFats)
        goalProtein = UserDefaults.standard.double(forKey: myGoalProtein)
        goalSodium = UserDefaults.standard.double(forKey: myGoalSod)
        goalCholest = UserDefaults.standard.double(forKey: myGoalCholest)
        goalCarbs = UserDefaults.standard.double(forKey: myGoalCarbs)
        goalSugars = UserDefaults.standard.double(forKey: myGoalSugar)
        
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
    
    //removes each of the meals in given day
    private func resetDayMeals(day: Int){
        for i in 0..<week.count{
            if(i==day){
                week[day].breakfast = nil
                week[day].lunch = nil
                week[day].dinner = nil
            }
        }
    }
        
    //removes every meal in every day of the week
    private func resetWeekMeals(){
        for i in 0..<week.count{
            resetDayMeals(day: i)
        }
    }

    func getNutrition(query: String) {
        ApiViewModel().loadData(query: self.query) { foods in
            print("\(query) in getNutrition")
            self.foods = foods
        }
    }
    
    //GOALS: get updated by user
    //need to be updated each time user inputs their goal for the week ----> changes when user changes it
    func updateCals(c: Double)
    {
        UserDefaults.standard.set(weeklyCals, forKey: myWeekCals)
    }
        
    func updateFats(f: Double)
    {
        UserDefaults.standard.set(weeklyFats, forKey: myWeekFats)
    }
    func updateProtein(p: Double)
    {
        UserDefaults.standard.set(weeklyProtein, forKey: myWeekProtein)
    }
    func updateSodium(s: Double)
    {
        UserDefaults.standard.set(weeklySodium, forKey: myWeekSod)
    }
    func updateCholest(c: Double)
    {
        UserDefaults.standard.set(weeklyCholest, forKey: myWeekCholest)
    }
    func updateCarbs(c: Double)
    {
        UserDefaults.standard.set(weeklyCarbs, forKey: myWeekCarbs)
    }
    func updateSugar(s: Double)
    {
        UserDefaults.standard.set(weeklySugars, forKey: myWeekSugar)
    }
         
    //WEEKLY: dont get touched by user
    //What they have currently out of their goals ---> what gets updated at midnight
    func updateWeeklyNutrition(cals: Double, fats: Double, pro: Double, sod: Double, cholest: Double, carbs: Double, sugar: Double)
    {
        weeklyCals += cals
        UserDefaults.standard.set(weeklyCals, forKey: myWeekCals)
        weeklyFats += fats
        UserDefaults.standard.set(weeklyFats, forKey: myWeekFats)
        weeklyProtein += pro
        UserDefaults.standard.set(weeklyProtein, forKey: myWeekProtein)
        weeklySodium += sod
        UserDefaults.standard.set(weeklySodium, forKey: myWeekSod)
        weeklyCholest += cholest
        UserDefaults.standard.set(weeklyCholest, forKey: myWeekCholest)
        weeklyCarbs += carbs
        UserDefaults.standard.set(weeklyCarbs, forKey: myWeekCarbs)
        weeklySugars += sugar
        UserDefaults.standard.set(weeklySugars, forKey: myWeekSugar)
            
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
          save a breakfast in a Day object
       */
    func addBreakfast(f: Food, dayNum: Int)
    {
        let newBreakfast = Food(name: f.name, calories: f.calories, serving_size_g: f.serving_size_g, fat_total_g: f.fat_total_g, fat_saturated_g: f.fat_saturated_g, protein_g: f.protein_g, sodium_mg: f.sodium_mg, potassium_mg: f.potassium_mg, cholesterol_mg: f.cholesterol_mg, carbohydrates_total_g: f.cholesterol_mg, fiber_g: f.fiber_g, sugar_g: f.sugar_g)
          weekDay[dayNum].breakfast = newBreakfast
          saveMeal()
          saveWeek()
    }
       
    /*
        save a lunch in a Day object
    */
    func addLunch(f: Food, dayNum: Int)
    {
        let newLunch = Food(name: f.name, calories: f.calories, serving_size_g: f.serving_size_g, fat_total_g: f.fat_total_g, fat_saturated_g: f.fat_saturated_g, protein_g: f.protein_g, sodium_mg: f.sodium_mg, potassium_mg: f.potassium_mg, cholesterol_mg: f.cholesterol_mg, carbohydrates_total_g: f.cholesterol_mg, fiber_g: f.fiber_g, sugar_g: f.sugar_g)
          weekDay[dayNum].lunch = newLunch
        saveMeal()
        saveWeek()
    }
       
    /*
        save a dinner in a Day object
    */
    func addDinner(f: Food, dayNum: Int)
    {
        let newDinner = Food(name: f.name, calories: f.calories, serving_size_g: f.serving_size_g, fat_total_g: f.fat_total_g, fat_saturated_g: f.fat_saturated_g, protein_g: f.protein_g, sodium_mg: f.sodium_mg, potassium_mg: f.potassium_mg, cholesterol_mg: f.cholesterol_mg, carbohydrates_total_g: f.cholesterol_mg, fiber_g: f.fiber_g, sugar_g: f.sugar_g)
        weekDay[dayNum].dinner = newDinner
        saveMeal()
        saveWeek()
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
