//
//  TabView.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 12/5/2024.
//

import SwiftUI
struct foodselected:Identifiable{
    var id = UUID()
    var food:String
    var tab:Tab
}
var selectedTab:[foodselected] = [
    foodselected(food: "Breakfast", tab: .Breakfast),
    foodselected(food: "Lunch", tab: .Lunch),
    foodselected(food: "Dinner", tab: .Dinner),
    foodselected(food: "Snacks", tab: .Snacks)
]
enum Tab:String{
    case Breakfast
    case Lunch
    case Dinner
    case Snacks
}



struct TabView: View {
    @Binding var itemselected :Tab
    var body: some View {
        HStack(spacing: 30){
            ForEach(selectedTab) { item in
                Button(action: {
                    withAnimation{
                        itemselected = item.tab
                    }
                }, label: {
                    Text(item.food)
                        .foregroundColor(itemselected == item.tab ? .white : .black)
                        .padding(8)
                        .background(itemselected == item.tab ? .black : Color(""))
                        .cornerRadius(10)
                })
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews : some View {
        TabView(itemselected: .constant(.Breakfast))
    }
}
