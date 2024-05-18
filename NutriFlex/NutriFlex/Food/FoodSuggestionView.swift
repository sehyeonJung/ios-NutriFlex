//
//  Food.swift
//  NutriFlex
//
//  Created by Ridhi Kathuria on 16/5/2024.
//  FoodSuggestion.swift

import SwiftUI
import Combine

struct FoodSuggestionView: View {
    @StateObject private var viewModel = FoodSuggestionViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(viewModel: viewModel)
                ProteinSelectionView(viewModel: viewModel)
                RecipeListView(viewModel: viewModel)
            }
            .navigationBarTitle("NutriFlex")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
