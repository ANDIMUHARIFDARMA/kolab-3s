//
//  RecipeCardView.swift
//  Tes
//
//  Created by ANDISAPUTRA on 05/03/25.
//
// Struktur data untuk decoding JSON


import SwiftUI

struct FoodRecipeView: View {
    var foodName: String
    var ingredients: Array<String>
    
    // State untuk melacak ketersediaan bahan baku
    @State private var availableIngredients: [String: Bool] = [:]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Food Name
            Text(foodName)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            
            // Ingredients List
            VStack(alignment: .leading, spacing: 8) {
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack {
                        Image(systemName: availableIngredients[ingredient] ?? false ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(availableIngredients[ingredient] ?? false ? .orange : .gray)
                        
                        Text(ingredient)
                            .font(.body)
                    }
                    .onTapGesture {
                        // Toggle status ketersediaan bahan
                        availableIngredients[ingredient] = !(availableIngredients[ingredient] ?? false)
                    }
                }
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
        .onAppear {
            // Inisialisasi dictionary dengan default false untuk setiap bahan
            for ingredient in ingredients {
                if availableIngredients[ingredient] == nil {
                    availableIngredients[ingredient] = false
                }
            }
        }
    }
}

struct FoodRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        FoodRecipeView(foodName: "Test", ingredients: ["Test"])
    }
}
