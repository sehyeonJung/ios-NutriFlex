//
//  ProfileView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 11/5/2024.
//

import SwiftUI

extension View {
    func dismissKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CalculatorView: View {
    
    @EnvironmentObject var vm: MealViewModel
    
    @State var age = ""
    @State var height: String = ""
    @State var weight: String = ""
    @State var userTargetKcal: String = ""
    
    @State var gender: String = "Male"
    @State var activity: String = "Minimal Activity"
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var isAlertShown: Bool = false
    @State var showNextButton: Bool = false
    @StateObject var mealViewModel = MealViewModel()
    
    @State var showInfoSheet: Bool = false
    
    let genderSelection: [String] = [
        "Male", "Female"
    ]
    
    let activitySelection: [String] = [
        "Minimal Activity", "Lightly active", "Moderately active", "Active", "Very active"
    ]
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor =
            UIColor.white
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        VStack {
//                            RingView(calorieValue: vm.userDailyCal)
//                                .environmentObject(MealViewModel())
                            
                            InfoButton
                            TextFieldInputs_CalcButton
                            Button {
                                kcalCalculator(gender: gender,
                                               activity: activity)
                                
                                resetTextField()
                                
                                showAlert.toggle()
                                showNextButton = true
                            } label: {
                                Text("Calculate")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .frame(height: 55)
                                    .frame(maxWidth: 120)
                                    .background(textFieldisValid() ?
                                                    Color.red : Color.black)
                                    .cornerRadius(10)
                                    .padding()
                            }
                            .disabled(!textFieldisValid())
                            .alert(isPresented: $showAlert, content: {
                                Alert(title: Text("Recommended daily calories:"), message: Text("\(vm.userDailyCal) kcal"))
                            })

                            TargetUserKcalSection
                            NavigationLink(destination: MainPageView()) {
                                                        Text("Home")
                                                            .foregroundColor(.blue)
                                                            .font(.headline)
                                                            .padding()
                                                    }
                                                
                        }
                        .padding()
                        Spacer()
                        Rectangle()
                            .frame(height: 40)
                            .opacity(0)
                        Rectangle()
                            .frame(height: 40)
                            .opacity(0)
                        Rectangle()
                            .frame(height: 40)
                            .opacity(0)
                    }
                }
            }
            .onTapGesture {
                self.dismissKeyBoard()
            }
            .navigationTitle("Calorie Calculator")
            .sheet(isPresented: $showInfoSheet, content: {
                InfoSheetView()
            })
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    func kcalCalculator(gender: String, activity: String) {
        if textFieldisValid() {
            var res = 0.0
            if gender == "Male" {
                let w = (13.75 * (Double(weight) ?? 0.0))
                let h = (5.003 * (Double(height) ?? 0.0))
                let a = (6.755 * (Double(age) ?? 0.0))
                let total = ((66.47  + w + h) - a)
                
                switch(activity) {
                case "Minimal Activity":
                    res = total * 1.2
                    break
                case "Lightly active":
                    res = total * 1.375
                    break
                case "Moderately active":
                    res = total * 1.55
                    break
                case "Active":
                    res = total * 1.725
                    break
                default:
                    // "Very active"
                    res = total * 1.9
                }
                vm.userDailyCal =
                    String(format: "%.0f", res)
                vm.addKcal(kcal: vm.userDailyCal)
            } else {
                let w = (9.563 * (Double(weight) ?? 0.0))
                let h = (1.850 * (Double(height) ?? 0.0))
                let a = (4.676 * (Double(age) ?? 0.0))
                let total = ((655.1 + w + h) - a)
                
                switch(activity) {
                case "Minimal Activity":
                    res = total * 1.2
                    break
                case "Lightly active":
                    res = total * 1.375
                    break
                case "Moderately active":
                    res = total * 1.55
                    break
                case "Active":
                    res = total * 1.725
                    break
                default:
                    // "Very active"
                    res = total * 1.9
                }
                
                vm.userDailyCal = String(format: "%.0f", res)
                vm.addKcal(kcal: vm.userDailyCal)
            }
            
        }
    }
    
    func textFieldisValid() -> Bool {
        if(age.count < 2 || weight.count < 2 || height.count < 3) {
            return false
        }
        return true
    }
    
    func directKcalTextFieldValidation() -> Bool {
        if(userTargetKcal.count < 3) {
            return false
        }
        return true
    }
    
    func resetTextField() {
        height = ""
        age = ""
        weight = ""
        userTargetKcal = ""
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .environmentObject(MealViewModel())
    }
}

extension CalculatorView {
    
    private var InfoButton: some View {
        HStack {
            Spacer()
            Button {
                showInfoSheet.toggle()
            } label: {
                Image(systemName: "info.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
        }
    }
    private var TextFieldInputs_CalcButton: some View {
        VStack {
            
            TextField("Age", text: $age)
                .padding(.horizontal)
                .frame(height: 45)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .font(.title)
                .keyboardType(.decimalPad)
            
            TextField("Height", text: $height)
                .padding(.horizontal)
                .frame(height: 45)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .font(.title)
                .keyboardType(.decimalPad)
            
            TextField("Weight", text: $weight)
                .padding(.horizontal)
                .frame(height: 45)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .font(.title)
                .keyboardType(.decimalPad)
            
            
            HStack(spacing: 0) { // Ensure no spacing between buttons
                ForEach(genderSelection.indices, id: \.self) { index in
                    GeometryReader { geometry in
                        Button(action: {
                            gender = genderSelection[index] // Update the selected gender
                        }) {
                            Text(genderSelection[index])
                                .foregroundColor(gender == genderSelection[index] ? .blue : .black) // Change color based on selection
                        }
                        .frame(width: geometry.size.width, height: 40) // Set the frame size based on GeometryReader
                        .background(gender == genderSelection[index] ? Color.blue.opacity(0.3) : Color.gray.opacity(0.3)) // Change background color based on selection
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
            Spacer()


            
            HStack {
                Text("Choose your activity :")
                    .font(.headline)
                Picker(
                    selection: $activity,
                    label: Text("Activity"),
                    content: {
                        ForEach(activitySelection.indices, id: \.self) { index in
                            Text(activitySelection[index])
                                .tag(activitySelection[index])
                        }
                    })
                .pickerStyle(MenuPickerStyle())
            }
            .frame(maxWidth: .infinity)
        }
    }
    private var TargetUserKcalSection: some View {
        VStack {
            TextField("Insert kcal directly", text: $userTargetKcal)
                .padding(.horizontal)
                .frame(height: 40)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .font(.headline)
                .keyboardType(.decimalPad)
            if directKcalTextFieldValidation() {
                Button {
                    vm.userDailyCal = userTargetKcal
                    vm.addKcal(kcal: vm.userDailyCal)
                    resetTextField()
                } label: {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 20)
                }
            }
        }
    }
}
