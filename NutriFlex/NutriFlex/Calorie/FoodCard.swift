//
//  FoodCard.swift
//  NutriFlex
//
//  Created by Carolyn Mario on 12/5/2024.
//

import SwiftUI

struct FoodCard: View {
    var width:CGFloat = 200
    @State var carbs:CGFloat = 20
    @State var protein:CGFloat = 200
    @State var fat:CGFloat = 70
    @State var name:String = ""
    @State var ingredient:String = ""
    @State var icon:String = ""
    var body: some View {
        let multiplier = width / 40
        return VStack(alignment: .leading, spacing: 2){
            HStack{
                Text(name)
                    .font(.title2)
                    .frame(width: 160)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .bold()
            HStack{
                Text(ingredient)
                Spacer()
            }
            .frame(width: 200, height:30)
            .minimumScaleFactor((0.6))
        }
        .offset(x:20, y: -20)
        .frame(width: 270, height: 110)
        .background(.white)
        .cornerRadius(10)
        .modifier(customShadow())
        .overlay(alignment: .topLeading, content: {
            Image("Bur")
                .resizable()
                .scaledToFill()
                .frame(width: 65, height: 65)
                .offset(x: -12, y: -1)
        })
        .overlay(alignment: .bottom, content: {
            HStack{
                Elements(name: "Carbs", foodElement: carbs, multiplier: multiplier, color: "Carbs")
                Elements(name: "Fat", foodElement: fat, multiplier: multiplier, color: "Fat")
                Elements(name: "Potein", foodElement: protein, multiplier: multiplier, color: "Protein")
            }
            
        })
        
    }
    
    struct FoodCard_Previews: PreviewProvider {
        static var previews: some View {
            FoodCard()
            
        }
    }
    
    struct Elements: View {
        var name = "name"
        var foodElement:CGFloat = 0
        var multiplier:CGFloat = 0
        var color = ""
        var body: some View{
            let width : CGFloat = 130
            let multiplier = width / 200
            return VStack{
                Text(name)
                    .font(.system(size: 12))
                Rectangle().frame(width: foodElement * multiplier, height: 5)
                    .cornerRadius(5)
                    .foregroundColor(Color(color))
            }
            .padding(.bottom,5)
        }
    }
}
