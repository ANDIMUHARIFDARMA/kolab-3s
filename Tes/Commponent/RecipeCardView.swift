//
//  RecipeCardView.swift
//  Tes
//
//  Created by ANDISAPUTRA on 05/03/25.
//

import SwiftUI

struct FoodRecipeView: View {
    var foodName: String = "Nama Makanan"
    var ingredients: [String] = ["Nama bahan 1", "Nama bahan 2", "Nama bahan 3"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
        
            // Food Name
            Text(foodName)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            // Subtitle
            Text("Resep dari AI:")
                .font(.headline)
                .foregroundColor(.gray)
            
            // Ingredients List
            VStack(alignment: .leading, spacing: 8) {
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.orange)
                        Text(ingredient)
                            .font(.body)
                    }
                }
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
    }
}

struct FoodRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        FoodRecipeView()
    }
}
