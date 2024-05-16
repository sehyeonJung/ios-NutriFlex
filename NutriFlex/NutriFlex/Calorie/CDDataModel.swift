//
//  CDDataModel.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 12/5/2024.
//

import Foundation
import CoreData
class cddatamodel:ObservableObject{
    let container : NSPersistentContainer
    @Published var saveBreakfastEntity:[BreakfastEntity] = []
    @Published var saveLunchEntity:[LunchEntity] = []
    @Published var saveValueEntity:[ValueEntity] = []
    init(){
        container = NSPersistentContainer(name: "CDfoodclass")
        container.loadPersistentStores{(descrip,errer) in
            if let errer = errer {
                print("error loading data \(errer)")
                
            }
        }
        fetchData()
    }
    func calculateDailyCalories() -> String {
        return "2000"
    }
    
    
    func fetchData(){
        let requestone = NSFetchRequest<BreakfastEntity>(entityName: "BreakfastEntity")
        let requestTwo = NSFetchRequest<LunchEntity>(entityName: "LunchEntity")
        let requestThree = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        do {
            saveBreakfastEntity = try container.viewContext.fetch(requestone)
            saveLunchEntity = try container.viewContext.fetch(requestTwo)
            saveValueEntity = try container.viewContext.fetch(requestThree)
            
        } catch let error {
            print("error facing data \(error)")
            
        }
    }
    func addBreakfast(icon:String,name:String,ingredients:String,fat:CGFloat,protein:CGFloat,carbs:CGFloat){
        let newmeal = BreakfastEntity(context: container.viewContext)
        newmeal.icon = icon
        newmeal.name = name
        newmeal.ingredients = ingredients
        newmeal.fat = Float(fat)
        newmeal.protein = Float(protein)
        newmeal.carbs = Float(carbs)
        saveData()
    }
    func addLunch(icon:String,name:String,ingredients:String,fat:CGFloat,protein:CGFloat,carbs:CGFloat){
        let newmeal = BreakfastEntity(context: container.viewContext)
        newmeal.icon = icon
        newmeal.name = name
        newmeal.ingredients = ingredients
        newmeal.fat = Float(fat)
        newmeal.protein = Float(protein)
        newmeal.carbs = Float(carbs)
        saveData()
    }
    func addValue(fat:CGFloat,protein:CGFloat,carbs:CGFloat){
        let newValue = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        do {
            let results = try container.viewContext.fetch(newValue)
            if let entity = results.first{
                entity.fat += Float(fat)
                entity.protein += Float(protein)
                entity.carbs += Float(carbs)
                
            }else{
                let newValue = ValueEntity(context: container.viewContext)
                newValue.fat = Float(fat)
                newValue.protein = Float(protein)
                newValue.carbs = Float(carbs)
            }
            saveData()
            fetchData()
        } catch {
            print("\(error)")
        }
    }
    
    func Addringcalories(calories:CGFloat){
        let newcal = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        do{
            let results = try container.viewContext.fetch(newcal)
            if let entity = results.first{
                entity.ring += Float(Int(calories))
            }else{
                let newEntity = ValueEntity(context: container.viewContext)
                newEntity.ring = 10
            }
        } catch {
            print("\(error)")
        }
        saveData()
        fetchData()
    }
    
    func addmealTaggle(meal:BreakfastEntity){
        meal.addmeal.toggle()
        saveData()
    }

    
    func saveData(){
        do {
            try container.viewContext.save()
        } catch {
            print("save data failed \(error)")
        }
    }
    
    
    
}
