//
//  swiftjinnn.swift
//  NutriFlex
//
//  Created by 정세현 on 15/5/2024.
//

import SwiftUI
import AVFoundation

struct HIITPage: View {
    @StateObject private var hiitViewModel = HIITViewModel()
    @State private var selectedExercise: HIITExercise?
    @State private var showExerciseDetails = false
    @State private var isTimerRunning = false
    @State private var timeRemaining: Int = 0
    @State private var timerIndex: Int = 0

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 20)], spacing: 20) {
                        ForEach(hiitViewModel.exercises) { exercise in
                            VStack(spacing: 8) {
                                Button(action: {
                                    selectedExercise = exercise
                                    showExerciseDetails = true
                                }) {
                                    Image(exercise.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 150, maxHeight: 150)
                                        .cornerRadius(30)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color.black, lineWidth: 2)
                                        )
                                }
                            }
                        }
                    }
                }
                .padding()
            }
           
        }
        .sheet(isPresented: $showExerciseDetails) {
            if let exercise = selectedExercise {
                ExerciseDetailView(exercise: exercise, onStartTimer: startTimer)
            }
        }
    }

    func startTimer(exercise: HIITExercise) {
        selectedExercise = exercise
        isTimerRunning = true
        timerIndex = 0
        timeRemaining = exercise.workInterval
    }

    func updateTimer(exercise: HIITExercise?) {
        guard let exercise = exercise else { return }
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timerIndex += 1
            if timerIndex < exercise.sets {
                if timerIndex % 2 == 0 {
                    timeRemaining = exercise.restInterval
                } else {
                    timeRemaining = exercise.workInterval
                }
            } else {
                isTimerRunning = false
            }
        }
    }
}

struct ExerciseDetailView: View {
    let exercise: HIITExercise
    let onStartTimer: (HIITExercise) -> Void

    @State private var isTimerRunning = false
    @State private var timeRemaining: Int = 0
    @State private var timerIndex: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(exercise.name)
                .font(.title)
            Image(exercise.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300, maxHeight: 300)
                .cornerRadius(30)
            Text(exercise.description)
                .font(.body)
            Button(action: {
                onStartTimer(exercise)
                isTimerRunning = true
                timeRemaining = exercise.workInterval
            }) {
                Text("Start")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }

            if isTimerRunning {
                VStack(spacing: 16) {
                    Text("Time Remaining: \(timeRemaining) seconds")
                        .font(.title)
                    HStack(spacing: 20) {
                        Button(action: {
                            isTimerRunning = false
                            timeRemaining = 0
                            timerIndex = 0
                        }) {
                            Image(systemName: "stop.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        Button(action: {
                            isTimerRunning.toggle()
                        }) {
                            Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                    if isTimerRunning {
                        updateTimer(exercise: exercise)
                    }
                }
            }
        }
        .padding()
    }

    func updateTimer(exercise: HIITExercise) {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timerIndex += 1
            if timerIndex < exercise.sets {
                if timerIndex % 2 == 0 {
                    timeRemaining = exercise.restInterval
                } else {
                    timeRemaining = exercise.workInterval
                }
            } else {
                isTimerRunning = false
            }
        }
    }
}


#Preview {
    HIITPage()
}
