//
//  Food.swift
//  NutriFlex
//
//  Created by Ridhi Kathuria on 16/5/2024.
//  FoodSuggestion.swift

import Foundation
import SwiftUI
import Combine

struct FoodSuggestion: View {
    @StateObject private var viewModel = FoodSuggestionViewModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationBar()
                ProteinSelectionView(viewModel: viewModel)
                RecipeListView(viewModel: viewModel)
            }
            .padding()
        }
    }
}

// NavigationBar.swift
struct NavigationBar: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            Spacer()
            Text("NutriFlex")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

// ProteinSelectionView.swift
struct ProteinSelectionView: View {
    @ObservedObject var viewModel: FoodSuggestionViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Choice of Protein")
                .fontWeight(.bold)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                ForEach(Protein.allCases, id: \.self) { protein in
                    ProteinButton(protein: protein, viewModel: viewModel)
                }
            }
        }
    }
}

// ProteinButton.swift
struct ProteinButton: View {
    let protein: Protein
    @ObservedObject var viewModel: FoodSuggestionViewModel

    var body: some View {
        Button(action: {
            viewModel.selectedProtein = protein
        }) {
            Text(protein.rawValue)
                .font(.caption)
                .foregroundColor(viewModel.selectedProtein == protein ? .white : .black)
                .padding()
                .background(viewModel.selectedProtein == protein ? Color.black : Color.gray)
                .cornerRadius(8)
        }
    }
}

// RecipeListView.swift
struct RecipeListView: View {
    @ObservedObject var viewModel: FoodSuggestionViewModel

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
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

// RecipeCard.swift
struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(recipe.title)
                .font(.title3)
                .fontWeight(.bold)
            Text(recipe.description)
                .font(.body)
            HStack {
                Text("Calories: \(recipe.calories)")
                Text("Protein: \(recipe.protein)g")
                Text("Carbs: \(recipe.carbs)g")
                Text("Fat: \(recipe.fat)g")
            }
            .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

// FoodSuggestionViewModel.swift
class FoodSuggestionViewModel: ObservableObject {
    @Published var selectedProtein: Protein = .goodForAnything
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false

    func loadRecipes() {
        isLoading = true
        //using Edamam API here
        
        let url = URL(string: "https://www.edamam.com/results/recipes/?search=salad")!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCache
