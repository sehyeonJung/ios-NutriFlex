//
//  AddView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 12/5/2024.
//

import SwiftUI
struct meal: Identifiable{
    var id = UUID()
    var image:String
}
var icons:[meal] = [
    meal(image: "vm1"),
    meal(image: "vm2"),
    meal(image: "vm3"),
    meal(image: "vm4"),
    meal(image: "vm5"),
    meal(image: "vm6"),
    meal(image: "vm7"),
    meal(image: "vm8"),
    meal(image: "vm9"),
    meal(image: "vm10"),
    meal(image: "vm11"),
    meal(image: "vm12"),

]
struct AddView: View {
    @Environment(\.presentationMode) var envi
    @EnvironmentObject var vm:cddatamodel
    @State var itemselected:Tab = .Breakfast
    @State var showicons:Bool = false
    @State var icon:String = "plus2"
    @State var name = ""
    @State var ingredient = ""
    @State var fat:String = "0"
    @State var protein:String = "0"
    @State var carbs: String = "0"
    @State var fatTF:Bool = false
    @State var proteinTF:Bool = false
    @State var carbsTF:Bool = false
   // @state var
    var body: some View {
        VStack{
            Spacer()
            TabView(itemselected: $itemselected)
            VStack(spacing: 25){
                Image(icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        withAnimation{
                            showicons.toggle()
                        }
                    }
                if showicons{
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack {
                            ForEach(icons) { item in
                                Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .onTapGesture {
                                        icon = item.image
                                        withAnimation{
                                            showicons.toggle()
                                        }
                                    }
                                
                            }
                        }
                    }
                    
                }
                
                VStack{
                    TextField("food", text: $name)
                    Divider()
                    TextField("ingredients", text: $ingredient)
                }
                .font(.title3)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .modifier(customShadow())
                VStack{
                    values(number:$fat, show: $fatTF, name: "Fat")
                    values(number:$protein, show: $proteinTF, name: "Protein")
                    values(number:$carbs, show: $carbsTF, name: "Carbs")
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .modifier(customShadow())
                Button(action: {
                    switch itemselected {
                    case .Breakfast:
                        vm.addBreakfast(icon: icon, name: name, ingredients: ingredient, fat: CGFloat(Int(fat) ?? 0), protein: CGFloat(Int(protein) ?? 0), carbs:CGFloat(Int(carbs) ?? 0))
                        envi.wrappedValue.dismiss()
                    case .Lunch:
                        vm.addLunch(icon: icon, name: name, ingredients: ingredient, fat: CGFloat(Int(fat) ?? 0), protein: CGFloat(Int(protein) ?? 0), carbs:CGFloat(Int(carbs) ?? 0))
                        envi.wrappedValue.dismiss()
                    case .Dinner:
                        print("Dinner")
                    case .Snacks:
                        print("Snacks")
                    }
                    
                }, label: {
                    Text("Save").bold()
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 180, height: 50)
                        .background(.white)
                        .cornerRadius(10)
                        .modifier(customShadow())
                    
                })
                
                
            }
            .padding()
            Spacer()
        }
        .overlay(alignment: .topTrailing, content: {
            Button(action: {
                envi.wrappedValue.dismiss()
            }, label: {
                ZStack{
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
                .modifier(customShadow())
                .padding()
            })
                   
        })
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(cddatamodel())
    }
}

struct values: View {
    @Binding var number:String
    @Binding var show:Bool
    var name = ""
    
    var body: some View {
        HStack{
            Text(name).bold()
                .font(.title2)
            Spacer()
            Text("\(number)").bold()
                .frame(width: 45, height: 30)
                .background(.black)
                .cornerRadius(5)
                .foregroundColor(.white)
                .onTapGesture {
                    withAnimation{
                        show.toggle()
                    }
                }
                                if show{
                                    ScrollView(.horizontal,showsIndicators: false){
                                    HStack(spacing: 5){
                                        ForEach(0 ..< 100) { item in
                                            Text("\(item)").bold()
                                                .frame(width: 30, height: 30)
                                                .background(.black.opacity(0.2))
                                                .cornerRadius(5)
                                                .onTapGesture {
                                                    withAnimation{
                                                    show.toggle()
                                                    number = "\(item)"
                                            }
                                        }
                                    }
                                }
                            }
                        .frame(width: 180, height: 30)
                        }
            
        }
        .padding(5)
    }
}
