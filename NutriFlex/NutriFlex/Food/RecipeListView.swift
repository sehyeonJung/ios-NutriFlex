//
//  RecipeListView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 18/5/2024.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: FoodSuggestionViewModel

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .foregroundColor(.black)
                .padding(.top)
        } else {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.recipes) { recipe in
                        RecipeCard(recipe: recipe)
                    }
                }
            }
        }
    }
}
