//
//  SIgnUpView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 11/5/2024.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @Binding var currentShowingView: String
    @AppStorage("uid") var userID: String = ""
    @State private var showNotification: Bool = false
    @EnvironmentObject var vm: cddatamodel

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var age: String = ""
    @State private var showAgeAlert: Bool = false

    private func isValidPassword(_ password: String) -> Bool {
        // MINIMUM 6 CHARACTERS LONG
        // 1 UPPERCASE
        // 1 SPECIAL CHAR
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)
    }
    
    private func isValidAge(_ ageString: String) -> Bool {
        if let age = Int(ageString) {
            return age >= 18
        }
        return false
    }

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("NUTRI FLEX")
                    .font(.system(size: 48, weight: .bold, design: .default))
                    .foregroundColor(Color.red)
                
                Text("Create an Account")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding(.bottom, 40)
                
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    if(email.count != 0) {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                    }
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    if(password.count != 0) {
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                    
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
                .padding()
                
//                NavigationLink(destination: CalculatorView(), isActive: $showNotification) {
//                    EmptyView()
//                }
                
                
                
                Button(action: {
                    if !isValidAge(age) {
                        showAgeAlert = true
                    } else {
                        signUp()
                    }
                }) {
                    Text("Create New Account")
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
                .alert(isPresented: $showAgeAlert) {
                    Alert(title: Text("Error"), message: Text("You must be over 18 years old to sign up."), dismissButton: .default(Text("OK")))
                }
                
                Spacer()
            }
        }
    }

    private func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                return
            }
            
            if let authResult = authResult {
                print(authResult.user.uid)
                userID = authResult.user.uid
                
                // Pass the name to the HomePageView
                UserDefaults.standard.set(name, forKey: "userName")
                showNotification = true
            }
        }
    }
}
