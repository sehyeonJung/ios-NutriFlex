//
//  WorkoutSuggestion.swift
//  NutriFlex
//
//  Created by 정세현 on 8/5/2024.
//
import SwiftUI

struct WorkoutSuggestion: View {
    @State private var selectedPage: Int = 1 // initial setting on page 1
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // title area
            HStack {
                Spacer()
                Text("NutriFlex")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .padding()
                }.padding()
                
                Text("workouts suggestion")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
            }
            
            // button area
            HStack(spacing: 20) {
                Button(action: {
                    selectedPage = 1
                }) {
                    Text("HIIT")
                        .foregroundColor(selectedPage == 1 ? .white : .black)
                        .padding()
                        .background(selectedPage == 1 ? Color.black : Color.gray)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    selectedPage = 2
                }) {
                    Text("CARDIO")
                        .foregroundColor(selectedPage == 2 ? .white : .black)
                        .padding()
                        .background(selectedPage == 2 ? Color.black : Color.gray)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    selectedPage = 3
                }) {
                    Text("WEIGHTS")
                        .foregroundColor(selectedPage == 3 ? .white : .black)
                        .padding()
                        .background(selectedPage == 3 ? Color.black : Color.gray)
                        .cornerRadius(8)
                }
            }
            
            // page area
            switch selectedPage {
            case 1:
                HIITpage()
            case 2:
                CardioPage()
            case 3:
                weightsView()
            default:
                EmptyView()
            }
        }
        .padding()
    }
}

struct HIITpage: View {
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    VStack{
                        Text("Treadmil")
                        Button(action: {
                            // button action
                        }) {
                            Image("Treadmil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150.0, height: 150.0).overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                        
                        
                    }.padding()
                    VStack{
                        Text("Rowing Machine")
                        Button(action: {
                            // button action
                        }) {
                            Image("Rowing")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }
                    
                }
                HStack{
                    VStack{
                        Text("Stepmil Machine")
                        
                        Button(action: {
                            // button action
                        }) {
                            Image("Stair")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height:150).overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }.padding()
                    VStack{
                        Text("Box Jump")
                        Button(action: {
                            // button action
                        }) {
                            Image("Boxjump")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }
                }
                HStack{
                    VStack{
                        Text("Pull Up")
                        Button(action: {
                            // button action
                        }) {
                            Image("Pullup")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                        
                    }.padding()
                    VStack{
                        Text("Bicycle")
                        Button(action: {
                            // button action
                        }) {
                            Image("Bicycle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150).overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }
                }
            }
        }
    }
}

struct CardioPage: View {
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("Treadmil")
                        .font(.headline)
                    Spacer()
                }
                HStack{
                    Image("Treadmil")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100).overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    VStack{
                        Text("A treadmill is a stationary exercise device that mimics walking or running.").padding()
                        Text("300-600kcal/h")
                            .font(.headline)
                    }
                }
                
                HStack{
                    Text("Rowing Machine")
                        .font(.headline)
                    Spacer()
                }
                HStack{
                    Image("Rowing").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100).overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    VStack{
                        Text("A rowing machine is an effective indoor exercise device for improving flexibility and strength.").padding()
                        Text("300-600kcal/h")
                            .font(.headline)
                    }
                }
                HStack{
                    Text("Stepmil Machine")
                        .font(.headline)
                    Spacer()
                }
                HStack{
                    Image("Stair").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100).overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    VStack{
                        Text("Stair climbing combines aerobic and strength training exercises, strengthening leg muscles and cardiovascular function as you ascend and descend stairs").padding()
                        Text("500-800kcal/h")
                            .font(.headline)
                    }
                }
                
            }
        }
    }
}
struct weightsView: View {
    var body: some View {
        ScrollView{
            VStack{
                Text("Which Bodypart to Train?")
                    .font(.title)
                    .fontWeight(.bold)
                HStack{
                    Button(action: {
                        // button action
                    }) {
                        Image("abs")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150).overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                    Button(action: {
                        // button action
                    }) {
                        Image("glutes")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150).overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                }
                /*
                HStack{
                    Button(action: {
                        // button action
                    }) {
                        Image("")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 50)
                    }
                    Button(action: {
                        // button action
                    }) {
                        Image("")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 50)
                    }
                }
                */
                HStack{
                    Button(action: {
                        // button action
                    }) {
                        Image("biceps")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150).overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                    Button(action: {
                        // button action
                    }) {
                        Image("quads", bundle: .main)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150).overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                }
            }
            //add more
            Button(action: {
                // button action
            }) {
                Image("triceps", bundle: .main)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150).overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
        }
    }
}

#Preview {
    WorkoutSuggestion()
}

