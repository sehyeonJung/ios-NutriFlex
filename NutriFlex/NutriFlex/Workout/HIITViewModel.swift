//
//  HIITViewModel.swift
//  NutriFlex
//
//  Created by 정세현 on 15/5/2024.
//

import Foundation

class HIITViewModel: ObservableObject {
    @Published var exercises: [HIITExercise] = []

    init() {
        fetchExercises()
    }

    func fetchExercises() {
        let exercise1 = HIITExercise(id: UUID(), name: "Treadmill", image: "Treadmil", description: "The treadmill HIIT workout involves 30 seconds of high-intensity running or sprinting followed by 1 minute of active recovery walking. Repeat this interval 8 times for a total of 12 minutes. This workout targets your cardiovascular fitness and works your legs and core.", duration: 720, workInterval: 30, restInterval: 60, sets: 8)
        
        let exercise2 = HIITExercise(id: UUID(), name: "Rowing Machine", image: "Rowing", description: "The rowing HIIT workout involves 45 seconds of high-intensity rowing followed by 1 minute of active recovery rowing at a slower pace. Repeat this interval 6 times for a total of 12 minutes. This exercise focuses on your upper body, back, and core muscles to build strength and endurance.", duration: 720, workInterval: 45, restInterval: 60, sets: 6)
        
        let exercise3 = HIITExercise(id: UUID(), name: "Pull Up", image: "Pullup", description: "The pull-up HIIT workout involves 20 seconds of high-intensity pull-ups followed by 40 seconds of active recovery. Repeat this interval 10 times for a total of 10 minutes. This exercise targets your upper body, back, and core muscles.", duration: 600, workInterval: 20, restInterval: 40, sets: 10)
        
        let exercise4 = HIITExercise(id: UUID(), name: "Stair Climbing", image: "Stair", description: "The stair climbing HIIT workout involves 1 minute of high-intensity stair climbing followed by 1 minute of active recovery walking. Repeat this interval 6 times for a total of 12 minutes. This exercise works your legs, glutes, and cardiovascular system.", duration: 720, workInterval: 60, restInterval: 60, sets: 6)
        
        let exercise5 = HIITExercise(id: UUID(), name: "Indoor Bicycle", image: "Bicycle", description: "The indoor bicycle HIIT workout involves 40 seconds of high-intensity cycling followed by 20 seconds of active recovery. Repeat this interval 12 times for a total of 12 minutes. This exercise targets your leg muscles and cardiovascular fitness.", duration: 720, workInterval: 40, restInterval: 20, sets: 12)
        
        let exercise6 = HIITExercise(id: UUID(), name: "Burpee", image: "Burpee", description: "The burpee HIIT workout involves 30 seconds of high-intensity burpees followed by 30 seconds of active recovery. Repeat this interval 10 times for a total of 10 minutes. This exercise works your entire body, including your legs, core, and upper body.", duration: 600, workInterval: 30, restInterval: 30, sets: 10)
        
        let exercise7 = HIITExercise(id: UUID(), name: "Jump Rope", image: "JumpRope", description: "The jump rope HIIT workout involves 45 seconds of high-intensity jumping followed by 15 seconds of active recovery. Repeat this interval 8 times for a total of 8 minutes. This exercise improves coordination, agility, and cardiovascular fitness.", duration: 480, workInterval: 45, restInterval: 15, sets: 8)
        
        let exercise8 = HIITExercise(id: UUID(), name: "Side Jump", image: "SideJump", description: "The side jump HIIT workout involves 20 seconds of high-intensity lateral jumps followed by 40 seconds of active recovery. Repeat this interval 10 times for a total of 10 minutes. This exercise works your leg muscles, core, and balance.", duration: 600, workInterval: 20, restInterval: 40, sets: 10)
        
        let exercise9 = HIITExercise(id: UUID(), name: "Squat Jump", image: "SquartJump", description: "The squat jump HIIT workout involves 30 seconds of high-intensity squat jumps followed by 30 seconds of active recovery. Repeat this interval 10 times for a total of 10 minutes. This exercise targets your leg muscles, core, and cardiovascular system.", duration: 600, workInterval: 30, restInterval: 30, sets: 10)
        
        exercises = [exercise1, exercise2, exercise3, exercise4, exercise5, exercise6, exercise7, exercise8, exercise9]
    }
}

struct HIITExercise: Identifiable {
    let id: UUID
    let name: String
    let image: String
    let description: String
    let duration: Int
    let workInterval: Int
    let restInterval: Int
    let sets: Int
}


