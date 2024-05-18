//
//  RecipeCard.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 18/5/2024.
//
import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    } else {
                        Color.gray.frame(height: 200)
                    }
                }
                .cornerRadius(8)
            }
            Text(recipe.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Button(action: {
                guard let recipeURL = URL(string: recipe.url) else { return }
                UIApplication.shared.open(recipeURL)
            }) {
                Text("Find instructions")
                    .font(.body)
                    .foregroundColor(.white)
            }
            HStack {
                Text("Calories: \(Int(recipe.calories))")
                Text("Protein: \(Int(recipe.protein))g")
                Text("Carbs: \(Int(recipe.carbs))g")
                Text("Fat: \(Int(recipe.fat))g")
            }
            .font(.caption)
            .foregroundColor(.white)
        }
        .padding() // Add padding to the content inside the card
        .background(Color.gray)
        .cornerRadius(8)
        .padding(4) // Add padding to the borders of the card
        .background(Color.black) // Add background color to the outer padding for border effect
        .cornerRadius(8)
    }
}

