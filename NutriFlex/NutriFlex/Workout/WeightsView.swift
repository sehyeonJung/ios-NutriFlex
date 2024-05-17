//
//  weightsView.swift
//  NutriFlex
//
//  Created by 정세현 on 15/5/2024.
//
import SwiftUI
import Combine
//in the case of using api
/*
struct WeightsView: View {
    @StateObject private var viewModel = WeightViewModel(apiKey: "ba3247aca702b635a47ae91da4d5fc0126ea2cf4")

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Picker("Body Part", selection: $viewModel.selectedBodyPart) {
                    ForEach(BodyPart.allCases, id: \.self) { bodyPart in
                        Text(bodyPart.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.exercises) { exercise in
                            ExerciseView(exercise: exercise)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchExercises()
        }
    }
}

struct ExerciseView: View {
    let exercise: Exercise

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(exercise.name)
                .font(.title2)
                .fontWeight(.bold)

            if let firstImageURL = exercise.images?.first.flatMap(URL.init) {
                AsyncImage(url: firstImageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 150)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 150)
                            .cornerRadius(10)
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: 150, maxHeight: 150)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            Text(exercise.description)
                .font(.body)
        }
    }
}

struct WeightsView_Previews: PreviewProvider {
    static var previews: some View {
        WeightsView()
    }
}

*/

import SwiftUI
import AVKit

struct WeightsView: View {
    @StateObject private var shoulderViewModel = ShoulderViewModel()
    @StateObject private var chestViewModel = ChestViewModel()
    @StateObject private var backViewModel = BackViewModel()
    @StateObject private var legViewModel = LegViewModel()
    
    @State private var selectedBodyPart: BodyPart = .shoulder
    
    var body: some View {
        VStack {
            BodyPartButtonBar(selectedBodyPart: $selectedBodyPart)
            
            switch selectedBodyPart {
            case .shoulder:
                ExerciseView(title: "Shoulder", exercises: shoulderViewModel.exercises)
            case .chest:
                ExerciseView(title: "Chest", exercises: chestViewModel.exercises)
            case .back:
                ExerciseView(title: "Back", exercises: backViewModel.exercises)
            case .leg:
                ExerciseView(title: "Legs", exercises: legViewModel.exercises)
            }
        }
    }
}

struct BodyPartButtonBar: View {
    @Binding var selectedBodyPart: BodyPart
    
    var body: some View {
        HStack {
            BodyPartButton(title: "Shoulder", bodyPart: .shoulder, selectedBodyPart: $selectedBodyPart)
            BodyPartButton(title: "Chest", bodyPart: .chest, selectedBodyPart: $selectedBodyPart)
            BodyPartButton(title: "Back", bodyPart: .back, selectedBodyPart: $selectedBodyPart)
            BodyPartButton(title: "Legs", bodyPart: .leg, selectedBodyPart: $selectedBodyPart)
        }
        .padding(.vertical)
    }
}

struct BodyPartButton: View {
    let title: String
    let bodyPart: BodyPart
    @Binding var selectedBodyPart: BodyPart
    
    var body: some View {
        Button(action: {
            selectedBodyPart = bodyPart
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(selectedBodyPart == bodyPart ? .blue : .gray)
        }
    }
}

enum BodyPart {
    case shoulder, chest, back, leg
}

struct ExerciseView<T: ExerciseProtocol & Identifiable>: View {
    let title: String
    let exercises: [T]
    
    var body: some View {
        NavigationView {
            List(exercises) { exercise in
                NavigationLink(destination: WeightDetailed(exercise: exercise)) {
                    HStack {
                        Image(exercise.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text(exercise.name)
                    }
                }
            }
            .navigationBarTitle(title)
        }
    }
}

protocol ExerciseProtocol {
    var name: String { get }
    var imageName: String { get }
    var description: String { get }
    var videoLink: String? { get }
}

struct WeightDetailed<T: ExerciseProtocol & Identifiable>: View {
    let exercise: T
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let videoLink = exercise.videoLink {
                    VideoPlayer(player: AVPlayer(url: URL(string: videoLink)!))
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                } else {
                    Image(exercise.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                
                Text(exercise.name)
                    .font(.title)
                    .bold()
                
                Text(exercise.description)
                    .font(.body)
                
                if let videoLink = exercise.videoLink {
                    Link("Watch on YouTube", destination: URL(string: videoLink)!)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}

#Preview {
    WeightsView()
}

