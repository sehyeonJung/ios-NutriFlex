//
//  FoodSuggestionViewModel.swift
//  NutriFlex
//
//  Created by 정세현 on 13/5/2024.
//

import Foundation
class FoodSuggestionViewModel: ObservableObject {
    @Published var selectedProtein: Protein = .goodForAnything
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    
    func loadRecipes() {
        isLoading = true
        fetchNutritionData(for: selectedProtein) { nutritionData in
            self.fetchRecipes(for: self.selectedProtein, with: nutritionData) { recipes in
                self.recipes = recipes
                self.isLoading = false
            }
        }
    }
    
    private func fetchNutritionData(for protein: Protein, completion: @escaping (NutritionData) -> Void) {
        // Use USDA API to get nutrition information for the selected protein
        let nutritionData = getNutritionData(for: protein)
        completion(nutritionData)
    }
    
    private func fetchRecipes(for protein: Protein, with nutritionData: NutritionData, completion: @escaping ([Recipe]) -> Void) {
        // Use Edamam API to search for recipes suitable for the selected protein
        let recipes = getRecipes(for: protein, with: nutritionData)
        completion(recipes)
    }
}

// Test data
func getNutritionData(for protein: Protein) -> NutritionData {
    switch protein {
    case .goodForAnything:
        return NutritionData(protein: 25.0, carbs: 30.0, fat: 15.0, calories: 350)
    case .beefBased:
        return NutritionData(protein: 30.0, carbs: 10.0, fat: 20.0, calories: 400)
    case .porkBased:
        return NutritionData(protein: 27.0, carbs: 15.0, fat: 18.0, calories: 380)
    case .chickenBased:
        return NutritionData(protein: 35.0, carbs: 5.0, fat: 12.0, calories: 320)
    case .eggBased:
        return NutritionData(protein: 28.0, carbs: 2.0, fat: 17.0, calories: 290)
    case .plantBased:
        return NutritionData(protein: 20.0, carbs: 40.0, fat: 10.0, calories: 300)
    }
}

func getRecipes(for protein: Protein, with nutritionData: NutritionData) -> [Recipe] {
    switch protein {
    case .goodForAnything:
        return [
            Recipe(title: "Grilled Chicken Salad", description: "A refreshing salad with grilled chicken, mixed greens, and a light vinaigrette.", calories: 350, protein: 30.0, carbs: 15.0, fat: 12.0),
            Recipe(title: "Baked Salmon with Roasted Vegetables", description: "Flaky salmon baked to perfection, served with a side of roasted seasonal vegetables.", calories: 420, protein: 35.0, carbs: 10.0, fat: 22.0),
            Recipe(title: "Lentil Soup", description: "A hearty lentil soup packed with vegetables and protein.", calories: 280, protein: 18.0, carbs: 35.0, fat: 5.0)
        ]
    case .beefBased:
        return [
            Recipe(title: "Beef Stir-Fry", description: "Tender beef and fresh vegetables in a savory sauce.", calories: 400, protein: 32.0, carbs: 12.0, fat: 18.0),
            Recipe(title: "Beef Burrito Bowl", description: "Seasoned ground beef, rice, beans, and your favorite toppings.", calories: 450, protein: 28.0, carbs: 40.0, fat: 15.0)
        ]
    case .porkBased:
        return [
            Recipe(title: "Pork Tenderloin with Roasted Potatoes", description: "Juicy pork tenderloin served with crispy roasted potatoes.", calories: 380, protein: 30.0, carbs: 25.0, fat: 14.0),
            Recipe(title: "Pork Fried Rice", description: "Stir-fried pork, rice, and vegetables in a savory sauce.", calories: 420, protein: 25.0, carbs: 45.0, fat: 12.0)
        ]
    case .chickenBased:
        return [
            Recipe(title: "Chicken Fajitas", description: "Grilled chicken, bell peppers, and onions in warm tortillas.", calories: 360, protein: 35.0, carbs: 30.0, fat: 10.0),
            Recipe(title: "Baked Chicken with Roasted Broccoli", description: "Tender baked chicken breast with a side of roasted broccoli.", calories: 320, protein: 40.0, carbs: 10.0, fat: 8.0)
        ]
    case .eggBased:
        return [
            Recipe(title: "Veggie Frittata", description: "Baked egg dish with a variety of vegetables.", calories: 290, protein: 18.0, carbs: 10.0, fat: 15.0),
            Recipe(title: "Egg Fried Rice", description: "Fried rice with scrambled eggs and vegetables.", calories: 350, protein: 20.0, carbs: 40.0, fat: 12.0)
        ]
    case .plantBased:
        return [
            Recipe(title: "Quinoa and Black Bean Burrito Bowl", description: "Protein-packed quinoa, black beans, and fresh toppings.", calories: 300, protein: 15.0, carbs: 45.0, fat: 8.0),
            Recipe(title: "Tofu Stir-Fry with Broccoli", description: "Marinated tofu and fresh broccoli in a flavorful sauce.", calories: 280, protein: 18.0, carbs: 30.0, fat: 10.0)
        ]
    }
}
