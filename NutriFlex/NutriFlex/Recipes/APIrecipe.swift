//
//  APIrecipe.swift
//  NutriFlex
//
//  Created by Ridhi Kathuria on 16/5/2024.
//

import Foundation
import Foundation

struct APIrecipe {
    static let apiKey = "13944f6825a32b9e4d50168e00848ce0"
    static let baseURL = "https://www.edamam.com/results/recipes/?search=salad"

    static func getRecipeDetails(recipeId: Int, completion: @escaping (Recipe?, Error?) -> Void) {
        let urlString = "\(baseURL)/\(recipeId)/information?apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "", code: -1, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "", code: -1, userInfo: nil))
                return
            }

            do {
                let recipe = try JSONDecoder().decode(Recipe.self, from: data)
                completion(recipe, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let instructions: String
    let extendedIngredients: [ExtendedIngredient]

    struct ExtendedIngredient: Codable {
        let id: Int
        let name: String
        let amount: Double
        let unit: String
    }
}
