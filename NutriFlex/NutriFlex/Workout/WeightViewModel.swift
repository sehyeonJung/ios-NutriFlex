//
//  weightViewModel.swift
//  NutriFlex
//
//  Created by 정세현 on 15/5/2024.
//
import SwiftUI
import Combine
//in the case of using api
/*
 class WeightViewModel: ObservableObject {
 @Published var exercises: [Exercise] = []
 @Published var selectedBodyPart: BodyPart = .chest
 
 private var cancellables = Set<AnyCancellable>()
 private let apiKey: String
 
 init(apiKey: String) {
 self.apiKey = apiKey
 fetchExercises()
 }
 
 func fetchExercises() {
 let bodyPartMap: [BodyPart: Int] = [
 .chest: 5, // Chest
 .legs: 6, // Legs
 .shoulders: 4, // Shoulders
 .arms: 1, // Arms
 .back: 12 // Back
 ]
 
 guard let muscleID = bodyPartMap[selectedBodyPart] else {
 return
 }
 
 guard let url = URL(string: "https://wger.de/api/v2/exercise/?muscles=\(muscleID)") else {
 return
 }
 
 var request = URLRequest(url: url)
 request.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
 
 URLSession.shared.dataTaskPublisher(for: request)
 .tryMap { data, response in
 guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
 throw URLError(.badServerResponse)
 }
 return data
 }
 .decode(type: ExerciseResponse.self, decoder: JSONDecoder())
 .map { $0.results }
 .receive(on: DispatchQueue.main)
 .sink(
 receiveCompletion: { completion in
 switch completion {
 case .failure(let error):
 print("Error fetching exercises: \(error)")
 case .finished:
 break
 }
 },
 receiveValue: { exercises in
 self.exercises = Array(exercises.prefix(5))
 }
 )
 .store(in: &cancellables)
 }
 }
 
 struct ExerciseResponse: Codable {
 let results: [Exercise]
 }
 
 struct Exercise: Codable, Identifiable {
 let id: Int
 let name: String
 let description: String
 let images: [String]? // Array of image URLs
 let category: Int? // We will not use this for now -
 let muscles: [Int]? // We will not use this for now - Optional
 }
 
 enum BodyPart: String, CaseIterable {
 case chest = "Chest"
 case legs = "Legs"
 case shoulders = "Shoulders"
 case arms = "Arms"
 case back = "Back"
 }
 */

import Foundation



struct ShoulderExercise: Identifiable, ExerciseProtocol {
    let id: UUID
    let name: String
    let imageName: String
    let description: String
    let videoLink: String?
}

struct ChestExercise: Identifiable, ExerciseProtocol {
    let id: UUID
    let name: String
    let imageName: String
    let description: String
    let videoLink: String?
}

struct BackExercise: Identifiable, ExerciseProtocol {
    let id: UUID
    let name: String
    let imageName: String
    let description: String
    let videoLink: String?
}

struct LegExercise: Identifiable, ExerciseProtocol {
    let id: UUID
    let name: String
    let imageName: String
    let description: String
    let videoLink: String?
}

class ShoulderViewModel: ObservableObject {
    @Published var exercises: [ShoulderExercise] = []

    init() {
        fetchExercises()
    }

    func fetchExercises() {
        let exercise1 = ShoulderExercise(id: UUID(), name: "Overhead Press", imageName: "OverheadPress", description: "The overhead press is a shoulder exercise that targets the deltoids and works the entire upper body.", videoLink: "https://www.youtube.com/watch?v=CnBmiBqp-AI")
        let exercise2 = ShoulderExercise(id: UUID(), name: "Lateral Raises", imageName: "LateralRaises", description: "Lateral raises are a shoulder exercise that targets the middle deltoids.", videoLink: "https://www.youtube.com/watch?v=6_5D-W7hsKg")
        let exercise3 = ShoulderExercise(id: UUID(), name: "Front Raises", imageName: "FrontRaises", description: "Front raises are a shoulder exercise that targets the anterior deltoids.", videoLink: "https://www.youtube.com/watch?v=FBbPwEf2aL4")
        let exercise4 = ShoulderExercise(id: UUID(), name: "Shrugs", imageName: "DumbbellShrug", description: "Shrugs are a shoulder exercise that targets the upper trapezius muscle.", videoLink: "https://www.youtube.com/watch?v=Xyd_fa5zoEU")
        let exercise5 = ShoulderExercise(id: UUID(), name: "Arnold Press", imageName: "ArnoldPress", description: "The Arnold press is a shoulder exercise that targets all three deltoid heads.", videoLink: "https://www.youtube.com/watch?v=F6-ELQMaxxs")
        
        exercises = [exercise1, exercise2, exercise3, exercise4, exercise5]
    }
}

class ChestViewModel: ObservableObject {
    @Published var exercises: [ChestExercise] = []

    init() {
        fetchExercises()
    }

    func fetchExercises() {
        let exercise1 = ChestExercise(id: UUID(), name: "Bench Press", imageName: "BenchPress", description: "The bench press is a chest exercise that targets the pectoralis major and anterior deltoids.", videoLink: "https://www.youtube.com/watch?v=rT7DgCr-3pg")
        let exercise2 = ChestExercise(id: UUID(), name: "Pushup", imageName: "Pushup", description: "Pushups are a bodyweight chest exercise that targets the pectoralis major and triceps.", videoLink: "https://www.youtube.com/watch?v=IODxDxX7oi4")
        let exercise3 = ChestExercise(id: UUID(), name: "Dumbbell Fly", imageName: "DumbbellFly", description: "Dumbbell flyes are a chest isolation exercise that targets the pectoralis major.", videoLink: "https://www.youtube.com/watch?v=oHc3sSida-0")
        let exercise4 = ChestExercise(id: UUID(), name: "Cable Crossover", imageName: "CableCrossover", description: "Cable crossovers are a chest exercise that targets the pectoralis major.", videoLink: "https://www.youtube.com/watch?v=Asrj2LBhUs8")
        let exercise5 = ChestExercise(id: UUID(), name: "Incline Bench Press", imageName: "InclineBenchPress", description: "The incline bench press is a chest exercise that targets the upper pectoralis major.", videoLink: "https://www.youtube.com/watch?v=8b7DuFmLc7Q")
        
        exercises = [exercise1, exercise2, exercise3, exercise4, exercise5]
    }
}

class BackViewModel: ObservableObject {
    @Published var exercises: [BackExercise] = []

    init() {
        fetchExercises()
    }

    func fetchExercises() {
        let exercise1 = BackExercise(id: UUID(), name: "Lat Pulldown", imageName: "LatPulldown", description: "The lat pulldown is a back exercise that targets the latissimus dorsi.", videoLink: "https://www.youtube.com/watch?v=Hwfg_coBDgE")
        let exercise2 = BackExercise(id: UUID(), name: "Seated Row", imageName: "SeatedRow", description: "Seated rows are a back exercise that targets the upper back and biceps.", videoLink: "https://www.youtube.com/watch?v=rK-OA7gCCbE")
        let exercise3 = BackExercise(id: UUID(), name: "Deadlift", imageName: "Deadlift", description: "The deadlift is a compound leg and back exercise that targets the posterior chain.", videoLink: "https://www.youtube.com/watch?v=hCDzSR6bW10")
        let exercise4 = BackExercise(id: UUID(), name: "Hyperextensions", imageName: "Hyperextensions", description: "Hyperextensions are a back exercise that targets the lower back and glutes.", videoLink: "https://www.youtube.com/watch?v=JKkKqGmZ_sQ")
        let exercise5 = BackExercise(id: UUID(), name: "Bent-over Row", imageName: "BentoverRow", description: "The bent-over row is a back exercise that targets the lats and biceps.", videoLink: "https://www.youtube.com/watch?v=Oj4_ZJ3fk4Y")
        
        exercises = [exercise1, exercise2, exercise3, exercise4, exercise5]
    }
}

class LegViewModel: ObservableObject {
    @Published var exercises: [LegExercise] = []

    init() {
        fetchExercises()
    }

    func fetchExercises() {
        let exercise1 = LegExercise(id: UUID(), name: "Squat", imageName: "Squat", description: "The squat is a compound leg exercise that targets the quadriceps, glutes, and hamstrings.", videoLink: "https://www.youtube.com/watch?v=bEv6CCg2BC8")
        let exercise2 = LegExercise(id: UUID(), name: "Deadlift", imageName: "Deadlift", description: "The deadlift is a compound leg and back exercise that targets the posterior chain.", videoLink: "https://www.youtube.com/watch?v=hCDzSR6bW10")
        let exercise3 = LegExercise(id: UUID(), name: "Lunge", imageName: "Lunge", description: "Lunges are a compound leg exercise that target the quadriceps, glutes, and hamstrings.", videoLink: "https://www.youtube.com/watch?v=RqA3iEcgX-s")
        let exercise4 = LegExercise(id: UUID(), name: "Leg Press", imageName: "LegPress", description: "The leg press is a compound leg exercise that targets the quadriceps, glutes, and hamstrings.", videoLink: "https://www.youtube.com/watch?v=fRCcWdHr3t8")
        let exercise5 = LegExercise(id: UUID(), name: "Romanian Deadlift", imageName: "RomanianDeadlift", description: "The Romanian deadlift is a compound leg and back exercise that targets the posterior chain.", videoLink: "https://www.youtube.com/watch?v=jEy_czb3RKA")

        exercises = [exercise1, exercise2, exercise3, exercise4, exercise5]
    }
}
