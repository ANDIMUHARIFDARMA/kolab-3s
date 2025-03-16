//
//  ContentView.swift
//  FoodVisionAI
//
//  Created by ANDISAPUTRA on 03/03/25.
//

import SwiftUI

struct GenerateSeiri: View {
    var nameFood: String?
    var ingredients: [String]?
    var steps: [String]?
    
    var body: some View {
        VStack {
            FoodRecipeView(foodName: nameFood ?? "", ingredients: ingredients ?? ["Tes"])// Upload Foto
            ResepView(steps: steps ?? [])
        }
    }
}

#Preview {
    GenerateSeiri()
}
