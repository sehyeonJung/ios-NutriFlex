//
//  FoodSuggestion.swift
//  NutriFlex
//
//  Created by 정세현 on 8/5/2024.
//

import SwiftUI
import Combine

struct FoodSuggestion: View {
    @StateObject private var viewModel = FoodSuggestionViewModel()
    
    var body: some View {
        VStack {
            // Navigation bar
            NavigationBar()
            
            // Protein selection view
            ProteinSelectionView(selectedProtein: $viewModel.selectedProtein) {
                viewModel.loadRecipes()
            }
            
            // Display recipes or show loading indicator
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                RecipesView(recipes: viewModel.recipes)
            }
        }
        .padding()
    }
}

// Navigation bar view
struct NavigationBar: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            // Back button
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            Spacer()
            
            // App title
            Text("NutriFlex")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
    }
}

// Protein selection view
struct ProteinSelectionView: View {
    @Binding var selectedProtein: Protein
    let onSelectionChanged: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Choice of Protein")
                .fontWeight(.bold)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                ForEach(Protein.allCases, id: \.self) { protein in
                    ProteinButton(protein: protein, selectedProtein: $selectedProtein)
                }
            }
        }
        .onChange(of: selectedProtein) { _ in
            onSelectionChanged()
        }
    }
}

// Protein button view
struct ProteinButton: View {
    let protein: Protein
    @Binding var selectedProtein: Protein
    
    var body: some View {
        Button(action: {
            selectedProtein = protein
        }) {
            Text(protein.rawValue)
                .font(.caption)
                .foregroundColor(selectedProtein == protein ? .white : .black)
                .padding()
                .background(selectedProtein == protein ? Color.black : Color.gray)
                .cornerRadius(8)
        }
    }
}

// Recipes view
struct RecipesView: View {
    let recipes: [Recipe]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Display recipe cards
                ForEach(recipes) { recipe in
                    RecipeCard(recipe: recipe)
                }
            }
        }
    }
}

// Recipe card view
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

// Protein enum
enum Protein: String, CaseIterable {
    case goodForAnything = "Good for Anything"
    case beefBased = "Beef Based"
    case porkBased = "Pork Based"
    case chickenBased = "Chicken Based"
    case eggBased = "Egg Based"
    case plantBased = "Plant Based"
}

// Nutrition data struct
struct NutritionData {
    let protein: Double
    let carbs: Double
    let fat: Double
    let calories: Double
}

// Recipe struct
struct Recipe: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    let calories: Int
    let protein: Double
    let carbs: Double
    let fat: Double
}

#Preview {
    FoodSuggestion()
}
