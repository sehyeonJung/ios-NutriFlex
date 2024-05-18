//
//  ProteinSelectionView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 18/5/2024.
//

import SwiftUI

struct ProteinSelectionView: View {
    @ObservedObject var viewModel: FoodSuggestionViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) { // Reduce spacing
            Text("Your Choice of Protein")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) { // Reduce spacing
                ForEach(Protein.allCases, id: \.self) { protein in
                    ProteinButton(protein: protein, viewModel: viewModel)
                        .frame(height: 30) // Reduce height
                }
            }
        }
        .padding(.horizontal) // Add horizontal padding
    }
}
