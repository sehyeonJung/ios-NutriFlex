//
//  SwiftUIView.swift
//  NutriFlex
//
//  Created by 정세현 on 15/5/2024.
//

import SwiftUI

struct WorkoutSuggestion: View {
    @State private var selectedPage: Int = 1 // initial setting on page 1
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // title area
            HStack {
                Spacer()
                Text("NutriFlex")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .padding()
                }.padding()
                
                Text("workouts suggestion")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
            }
            
            // button area
            HStack(spacing: 20) {
                Button(action: {
                    selectedPage = 1
                }) {
                    Text("HIIT")
                        .foregroundColor(selectedPage == 1 ? .white : .black)
                        .padding()
                        .background(selectedPage == 1 ? Color.black : Color.gray)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    selectedPage = 2
                }) {
                    Text("CARDIO")
                        .foregroundColor(selectedPage == 2 ? .white : .black)
                        .padding()
                        .background(selectedPage == 2 ? Color.black : Color.gray)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    selectedPage = 3
                }) {
                    Text("WEIGHTS")
                        .foregroundColor(selectedPage == 3 ? .white : .black)
                        .padding()
                        .background(selectedPage == 3 ? Color.black : Color.gray)
                        .cornerRadius(8)
                }
            }
            
            // page area
            switch selectedPage {
            case 1:
                HIITPage()
            case 2:
                CardioPage()
            case 3:
                WeightsView()
            default:
                EmptyView()
            }
        }
        .padding()
    }
}
#Preview {
    WorkoutSuggestion()
}
