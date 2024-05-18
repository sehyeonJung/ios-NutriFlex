//
//  MealViewModel.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 13/5/2024.
//

import Foundation
class MealViewModel: ObservableObject{
    
    
    @Published var userKcal:String = ""{
        didSet{
            saveUserKcal()
        }
    }
    
    
    
    
    @Published var userDailyCal:String = ""
    @Published var searchText:String = ""
    @Published var date = Date()
    
    //    let mealKey:String = "mealList"
    
    let kcalKey:String = "kcalCount"
    
    //    let favMeals:String = "favMealList"
    
    let userDKcal:String = "userKcal"
    
    
    
    
    
    //MARK: USER DAILY KCAL
    
    // Add user daily calorie needs
    func addKcal(kcal:String){
        let newKcal = kcal
        userKcal = newKcal
    }
    
    func getUserKcal(){
        guard
            let data = UserDefaults.standard.data(forKey: userDKcal),
            let savedKcal = try? JSONDecoder().decode(String.self, from: data)
        else {return}
        self.userKcal = savedKcal
    }
    // save user daily calorie needs
    func saveUserKcal(){
        if let encoded=try? JSONEncoder().encode(userKcal){
            UserDefaults.standard.set(encoded,forKey: userDKcal)
        }
    }
}
