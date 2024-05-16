//
//  LoginView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 11/5/2024.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var currentShowingView: String
    @AppStorage("uid") var userID: String = ""

        @State private var email: String = ""
        @State private var password: String = ""
        @State private var navigateToMainPageView = false
    @EnvironmentObject var vm: cddatamodel
    
    private func isValidPassword(_ password: String) -> Bool {
        // MINIMUM 6 CHARACTERS LONG
        // 1 UPPERCASE
        // 1 SPECIAL CHAR
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("NUTRI FLEX")
                    .font(.system(size: 60, weight: .bold, design: .default))
                    .foregroundColor(Color.red)
                    .padding(.bottom, 10)
                
                Text("Log in:")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "mail")
                        TextField("Email", text: $email)
                        
                        Spacer()
                        
                        if(email.count != 0) {
                            Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(email.isValidEmail() ? .green : .red)
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black)
                    )
                    
                    HStack {
                        Image(systemName: "lock")
                        SecureField("Password", text: $password)
                        
                        Spacer()
                        
                        if(password.count != 0) {
                            Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(isValidPassword(password) ? .green : .red)
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black)
                    )
                    
                    Button(action:{
                        withAnimation{
                            self.currentShowingView = "signup"
                        }
                    }){
                        Text("Don't have an account?")
                            .foregroundColor(.black.opacity(0.7))
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal)
                
                Button {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            withAnimation {
                                userID = authResult.user.uid
                            }
                        }
                      // ...
                    }
                    // Add your sign-up logic here
                    navigateToMainPageView = true
                } label: {
                    Text("Log In")
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
                .fullScreenCover(isPresented: $navigateToMainPageView) {
                 MainPageView()
                }
                
                
                Spacer()
            }
        }
    }
}

//navigateToHomePage = true
//} label: {
// Text("Log In")
//}
//.fullScreenCover(isPresented: $navigateToHomePage) {
// HomePageView()
//}
