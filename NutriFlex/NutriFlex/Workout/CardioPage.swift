//
//  CardioPage.swift
//  NutriFlex
//
//  Created by 정세현 on 15/5/2024.
//

import SwiftUI

struct CardioPage: View {
    @StateObject private var cardioViewModel = CardioViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(cardioViewModel.exercises) { exercise in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(exercise.name)
                            .font(.headline)
                        HStack(alignment: .top, spacing: 16) {
                            Image(exercise.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                            VStack(alignment: .leading, spacing: 8) {
                                Text(exercise.description)
                                Text("Calories per hour: \(exercise.caloriesPerHour)")
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}



#Preview {
    CardioPage()
}
