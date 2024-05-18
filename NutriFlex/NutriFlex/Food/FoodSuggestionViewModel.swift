//
//  APIrecipe.swift
//  NutriFlex
//
//  Created by Ridhi Kathuria on 16/5/2024.
//

import Foundation
import Combine

class FoodSuggestionViewModel: ObservableObject {
    @Published var selectedProtein: Protein = .goodForAnything
    @Published var searchQuery: String = ""
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false

    func loadRecipes() {
        isLoading = true
        var searchQuery = selectedProtein.rawValue.lowercased()
        if !self.searchQuery.isEmpty {
            searchQuery = self.searchQuery
        }
        let urlString = "https://api.edamam.com/api/recipes/v2?type=public&q=\(searchQuery)&app_id=47780f1c&app_key=896c7f7e5dcbe94e842564f61f834b3d"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            defer {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            if let error = error {
                print("Error fetching recipes: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let result = try JSONDecoder().decode(RecipeResponse.self, from: data)
                DispatchQueue.main.async {
                    self.recipes = result.hits.map { $0.recipe }
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}

struct RecipeResponse: Codable {
    let hits: [Hit]

    struct Hit: Codable {
        let recipe: Recipe
    }
}

struct Recipe: Codable, Identifiable {
    let id = UUID()
    let label: String
    let image: String?
    let url: String
    let calories: Double
    let totalNutrients: Nutrients

    var title: String {
        return label
    }

    var instructions: String {
        return "Find the instructions for this recipe here: \(url)"
    }

    var protein: Double {
        return totalNutrients.protein?.quantity ?? 0
    }

    var carbs: Double {
        return totalNutrients.carbs?.quantity ?? 0
    }

    var fat: Double {
        return totalNutrients.fat?.quantity ?? 0
    }
}

struct Nutrients: Codable {
    let protein: Nutrient?
    let carbs: Nutrient?
    let fat: Nutrient?

    struct Nutrient: Codable {
        let label: String
        let quantity: Double
    }
}

enum Protein: String, CaseIterable {
    case chicken
    case beef
    case fish
    case tofu
    case goodForAnything = "Anything"
}
