//
//  ContentView.swift
//  FoodVisionAI
//
//  Created by ANDISAPUTRA on 03/03/25.
//

import SwiftUI

struct SeitonView: View {
    var body: some View {
        ScrollView{
            VStack {
                HeaderView() // Header
                QuestionCardView() // Pertanyaan AI
                UploadPhotoView() // Upload Foto
            }
        }
    }
}

#Preview {
    SeitonView()
}
