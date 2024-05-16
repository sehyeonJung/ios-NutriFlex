//
//  CalorieView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 12/5/2024.
//

import SwiftUI
struct CalorieView: View {
    @EnvironmentObject var vm: cddatamodel
    @State var itemselected:Tab = .Breakfast
    @State var show = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Hi niki").bold()
                        .font(.system(size:35))
                    Spacer()
                    Image("Bur")
                        .resizable()
                        .scaledToFill()
                        .frame(width:50, height: 50)
                        .shadow(color: .blue, radius: 20, x: 0, y: 0)
                        .clipShape(Circle())
                }
                .padding(.horizontal)
                RingView()

                TabView(itemselected: $itemselected)
                if itemselected == .Breakfast{
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(vm.saveBreakfastEntity){ item in
                                FoodCard(width: 200, carbs: CGFloat(item.carbs), protein: CGFloat(item.carbs), fat: CGFloat(item.carbs), name: item.name ?? "", ingredient: item.ingredients ?? "", icon: item.icon ?? "")
                                    .padding(.leading)
                                    .overlay(alignment: .topTrailing, content: {
                                        Button(action: {
                                            vm.addValue(fat: CGFloat(item.fat), protein: CGFloat(item.protein), carbs: CGFloat(item.carbs))
                                            vm.addmealTaggle(meal: item)
                                            vm.Addringcalories(calories: CGFloat(item.carbs))
                                        }, label: {
                                            ZStack{
                                                Circle()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.white)
                                                Image(systemName: item.addmeal ? "checkmark" : "plus")
                                                    .imageScale(.small)
                                                    .foregroundColor(.black)
                                            }
                                            .modifier(customShadow())
                                        })
                                        .offset(x:-5, y:5)
                                    })
                            }
                        }
                        .frame(height: 180)

                    }
                    .offset(y: -30)
                }else if itemselected == .Lunch{
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(vm.saveLunchEntity){ item in
                                FoodCard(width: 200, carbs: CGFloat(item.carbs), protein: CGFloat(item.protein), fat: CGFloat(item.fat), name: item.name ?? "", ingredient: item.ingredients ?? "", icon: item.icon ?? "")
                                    .padding(.leading)
                            }
                            .frame(height: 180)
                        }
                        .offset(y: -30)
                    }
                }
                DrinkView()
                    .offset(y: -60)
                Spacer()
                ZStack {
                                    HStack {
                                        NavigationLink(destination: MainPageView()) {
                                            Text("Home").bold()
                                                .foregroundColor(.black)
                                                .frame(width: 150, height: 50)
                                                .background(Color.white)
                                                .clipShape(Capsule())
                                                .modifier(customShadow())
                                        }
                                        .padding()
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            show.toggle()
                                        }) {
                                            Text("New Meal").bold()
                                                .foregroundColor(.black)
                                                .frame(width: 150, height: 50)
                                                .background(Color.white)
                                                .clipShape(Capsule())
                                                .modifier(customShadow())
                                        }
                                        .padding()
                        }
                    }

                    .sheet(isPresented: $show, content: {
                        AddView()
                    })
            }
        }
        .navigationBarHidden(true)
    }
}


struct CalorieView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieView()
            .environmentObject(cddatamodel())
    }
}


