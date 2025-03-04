//
//  ContentView.swift
//  FoodVisionAI
//
//  Created by ANDISAPUTRA on 03/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView{
            VStack {
                HeaderView() // Header
                QuestionCardView() // Pertanyaan AI
                UploadPhotoView() // Upload Foto
            }
        }.frame(width: .infinity)
    }
}

#Preview {
    ContentView()
}
