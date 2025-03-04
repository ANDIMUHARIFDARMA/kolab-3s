//
//  HeaderView.swift
//  FoodVisionAI
//
//  Created by ANDISAPUTRA on 04/03/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image("photos") // Placeholder Logo
                .resizable() // Agar gambar bisa diubah ukurannya
                .scaledToFit() // Menjaga rasio aspek gambar
                .frame(width: 40, height: 40) // Sesuaikan ukuran gambar
                .clipShape(RoundedRectangle(cornerRadius: 8)) // Membuat gambar sedikit membulat
            Text("3S Culture Ai")
                .font(.headline)
                .bold()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HeaderView()
}
