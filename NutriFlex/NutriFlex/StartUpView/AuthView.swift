//
//  AuthView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 11/5/2024.
//

import SwiftUI

struct AuthView: View {
    @State private var currentViewShowing: String = "login"
    
    var body: some View {
        if currentViewShowing == "login" {
            LoginView(currentShowingView: $currentViewShowing) // Pass the binding property here
        } else {
            SignUpView(currentShowingView: $currentViewShowing)
        }
    }
}
