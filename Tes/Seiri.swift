//
//  Seiri.swift
//  Tes
//
//  Created by ANDISAPUTRA on 05/03/25.
//

import SwiftUI

struct SeiriView: View {
    var body: some View {
        ScrollView{
            VStack {
                HeaderView() // Header
                FoodCardView() // Pertanyaan AI
                UploadPhotoView() // Upload Foto
            }
        }.frame(width: .infinity)
    }
}

#Preview {
    SeiriView()
}
