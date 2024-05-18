//
//  NutriFlexApp.swift
//  NutriFlex
//
//  Created by 정세현 on 7/5/2024.
//

import SwiftUI

@main
struct NutriFlexApp: App {
    @StateObject private var dataController = DataController()
    @StateObject private var mealViewModel = MealViewModel()
    var body: some Scene {
        WindowGroup {
            MainPageView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(mealViewModel)
        }
    }
}
