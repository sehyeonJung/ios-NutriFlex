//
//  SearchBarView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 18/5/2024.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewModel: FoodSuggestionViewModel
    @State private var searchText = ""

    var body: some View {
        HStack {
            TextField("Search Recipes...", text: $searchText, onCommit: {
                viewModel.searchQuery = searchText
                viewModel.loadRecipes()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            Button(action: {
                viewModel.searchQuery = searchText
                viewModel.loadRecipes()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black) // Black color for icon
                    .padding()
            }
        }
        .padding()
        .background(Color.white) // Background color white
        .cornerRadius(8)
    }
}
