//
//  ProteinButton.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 18/5/2024.
//

import SwiftUI

struct ProteinButton: View {
    let protein: Protein
    @ObservedObject var viewModel: FoodSuggestionViewModel

    var body: some View {
        Button(action: {
            viewModel.selectedProtein = protein
            viewModel.loadRecipes()
        }) {
            Text(protein.rawValue.capitalized)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.horizontal, 12) // Reduce horizontal padding
                .padding(.vertical, 6) // Reduce vertical padding
                .background(viewModel.selectedProtein == protein ? Color.red : Color.gray)
                .cornerRadius(8)
        }
    }
}
