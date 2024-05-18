//
//  MainPageView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 13/5/2024.
//

import SwiftUI

struct MainPageView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @EnvironmentObject var vm: MealViewModel
    
    var body: some View {
        NavigationView {
            VStack{
            Spacer()
            
            Text("NUTRI FLEX")
                .font(.system(size: 60, weight: .bold, design: .default))
                .foregroundColor(Color.red)
                .padding(.bottom, 10)
                
                NavigationLink(destination: CalorieView()) {
                    Text("Calorie Tracker")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                }
                
                NavigationLink(destination: WorkoutSuggestion()) {
                    Text("Workouts")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                }
                
                NavigationLink(destination: FoodSuggestionView()) {
                    Text("Food Suggestions")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                }
                
                NavigationLink(destination: CalculatorView()) {
                    Text("Calorie Calculator")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                }
                
                Spacer()
            }
            
        }
        .navigationBarHidden(true)
    }

}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
            .environmentObject(MealViewModel())
        
            
    }
}
