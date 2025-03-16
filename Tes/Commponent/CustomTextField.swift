//
//  CustomTextField.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 05/03/25.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool
    
    var body: some View {
        if isSecure {
            SecureField(placeholder, text: $text)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .padding(.horizontal, 25)
                .font(.system(size: 12))
                .autocapitalization(.none) // Mencegah huruf pertama menjadi besar
                .textInputAutocapitalization(.never) // (iOS 15+)
                .autocorrectionDisabled(true) // Opsional: Matikan auto-correct
        } else {
            TextField(placeholder, text: $text)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .padding(.horizontal, 25)
                .font(.system(size: 12))
                .autocapitalization(.none) // Mencegah huruf pertama menjadi besar
                .textInputAutocapitalization(.never) // (iOS 15+)
                .autocorrectionDisabled(true) // Opsional: Matikan auto-correct

        }
    }
}

#Preview {
    CustomTextField(placeholder: "Masukkan teks", text: .constant(""), isSecure: false)
}

