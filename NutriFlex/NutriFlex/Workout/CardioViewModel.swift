//
//  CardioViewModel.swift
//  NutriFlex
//
//  Created by 정세현 on 15/5/2024.
//

import Foundation

import Foundation

class CardioViewModel: ObservableObject {
    @Published var exercises: [CardioExercise] = []

    init() {
        fetchExercises()
    }

    func fetchExercises() {
        let exercise1 = CardioExercise(id: UUID(), name: "Treadmill", image: "Treadmil", description: "The treadmill is a great cardio exercise that targets your cardiovascular fitness and works your legs and core.", caloriesPerHour: "300-600 kcal/h")
        
        let exercise2 = CardioExercise(id: UUID(), name: "Rowing Machine", image: "Rowing", description: "The rowing machine is an effective cardio exercise that focuses on your upper body, back, and core muscles.", caloriesPerHour: "300-600 kcal/h")
        
        
        let exercise4 = CardioExercise(id: UUID(), name: "Stair Climbing", image: "Stair", description: "Stair climbing is a cardio exercise that works your legs, glutes, and cardiovascular system.", caloriesPerHour: "500-800 kcal/h")
        
        let exercise5 = CardioExercise(id: UUID(), name: "Indoor Bicycle", image: "Bicycle", description: "The indoor bicycle is a cardio exercise that targets your leg muscles and cardiovascular fitness.", caloriesPerHour: "300-600 kcal/h")
        
        let exercise6 = CardioExercise(id: UUID(), name: "Burpee", image: "Burpee", description: "Burpees are a full-body cardio exercise that works your legs, core, and upper body.", caloriesPerHour: "500-800 kcal/h")
        
        let exercise7 = CardioExercise(id: UUID(), name: "Jump Rope", image: "JumpRope", description: "Jump roping is a cardio exercise that improves coordination, agility, and cardiovascular fitness.", caloriesPerHour: "500-800 kcal/h")
        
        let exercise8 = CardioExercise(id: UUID(), name: "Side Jump", image: "SideJump", description: "Side jumps are a cardio exercise that works your leg muscles, core, and balance.", caloriesPerHour: "500-800 kcal/h")
        
        let exercise9 = CardioExercise(id: UUID(), name: "Squat Jump", image: "SquartJump", description: "Squat jumps are a cardio exercise that targets your leg muscles, core, and cardiovascular system.", caloriesPerHour: "500-800 kcal/h")
        
        exercises = [exercise1, exercise2, exercise4, exercise5, exercise6, exercise7, exercise8, exercise9]
    }
}

struct CardioExercise: Identifiable {
    let id: UUID
    let name: String
    let image: String
    let description: String
    let caloriesPerHour: String
}
