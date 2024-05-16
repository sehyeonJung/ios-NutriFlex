//
//  SetUpView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 11/5/2024.
//

import SwiftUI
import Combine

struct SetUpView: View {
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var dietaryRequirements: [String] = []
    @State private var showAgeAlert: Bool = false
    @State private var isMainPageViewActive: Bool = false // Track if Next button is tapped
    
    let dietaryOptions = ["Vegetarian", "Vegan", "Gluten-free", "Dairy-free", "Keto", "Paleo", "Low-carb", "Nut-free"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text("NUTRI FLEX")
                        .font(.system(size: 48, weight: .bold, design: .default))
                        .foregroundColor(Color.red)
                    
                    Text("Lets get Started!")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding(.bottom, 40)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        TextField("Weight", text: $weight)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onReceive(Just(weight)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.weight = filtered
                                }
                            }
                        
                        
                        TextField("Height", text: $height)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onReceive(Just(height)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.height = filtered
                                }
                            }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Dietary Requirements:")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            ForEach(dietaryOptions, id: \.self) { option in
                                Toggle(option, isOn: Binding<Bool>(
                                    get: {
                                        dietaryRequirements.contains(option)
                                    },
                                    set: {
                                        if $0 {
                                            dietaryRequirements.append(option)
                                        } else {
                                            if let index = dietaryRequirements.firstIndex(of: option) {
                                                dietaryRequirements.remove(at: index)
                                            }
                                        }
                                    }
                                ))
                            }
                            
                        }
                        Spacer()
                        .padding()
                    }
        
                    .padding(.horizontal)
                    
                    NavigationLink(destination: MainPageView(), isActive: $isMainPageViewActive) {
                        EmptyView() // Invisible NavigationLink
                    }
                    
                    Button(action: {
                        // Perform validation here if needed
                        // For now, just navigate to HomePageView
                        self.isMainPageViewActive = true
                    }) {
                        Text("Lets Get Started!")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black)
                            )
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

//struct HomePageView: View {
//    var body: some View {
//        Text("Home Page")
//    }
//}

struct SetUpView_Previews: PreviewProvider {
    static var previews: some View {
        SetUpView()
    }
}
