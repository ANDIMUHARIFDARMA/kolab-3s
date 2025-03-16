//
//  SecureField.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 06/03/25.
//

import SwiftUI

struct PasswordField: View {
    @State private var isPasswordVisible = false
    @Binding var password: String
    
    var body: some View {
        HStack {
            if isPasswordVisible {
                TextField("Masukkan kata sandi", text: $password)
            } else {
                SecureField("Masukkan kata sandi", text: $password)
            }
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
        .padding(.horizontal, 25)
    }
}

#Preview {
    struct PreviewContainer: View {
        @State private var password = ""
        
        var body: some View {
            PasswordField(password: $password)
        }
    }
    
    return PreviewContainer()
}


