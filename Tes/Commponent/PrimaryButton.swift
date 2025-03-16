//
//  PrimaryButton.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 05/03/25.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange))
                .padding(.horizontal, 25)
        }
    }
}

#Preview {
    PrimaryButton(title: "Masuk"){
        print("Button tapped")
    }
}
