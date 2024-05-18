//
//  NavigationBar.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 18/5/2024.
//

import SwiftUI

struct NavigationBarView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack {
            Spacer()
            Text("NutriFlex")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.red) // Black color for text
            Spacer()
        }
        .padding()
    }
}
