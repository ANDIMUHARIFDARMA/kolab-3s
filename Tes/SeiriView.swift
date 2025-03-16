//
//  ContentView.swift
//  FoodVisionAI
//
//  Created by ANDISAPUTRA on 03/03/25.
//

import SwiftUI

struct SeiriView: View {
    var body: some View {
        ScrollView{
            VStack {
                HeaderView() // Header
                FoodCardView() // Pertanyaan
                UploadPhotoRecipe() // Upload Foto
            }
        }
    }
}

#Preview {
    SeiriView()
}
