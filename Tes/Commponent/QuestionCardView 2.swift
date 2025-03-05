//
//  QuestionCardView.swift
//  FoodVisionAI
//
//  Created by ANDISAPUTRA on 04/03/25.
//

import SwiftUI

struct QuestionCardView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // Ikon di kiri
            Image(systemName: "person.and.background.dotted")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.black)
                .padding(.top, 2) // Sedikit turun agar sejajar dengan teks

            VStack(alignment: .leading, spacing: 4) {
                Text("Seiton Ai")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("Seberapa rapi diri lo hari ini?")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray)
                .opacity(0.1)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                .overlay(
                            RoundedRectangle(cornerRadius: 15) // Sudut lengkung 15
                                .stroke(Color.orange, lineWidth: 1) // Warna border biru
                )
        )
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    QuestionCardView()
}

