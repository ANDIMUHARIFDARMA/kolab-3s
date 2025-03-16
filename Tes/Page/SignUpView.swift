//
//  SignUpView.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 06/03/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        VStack(spacing: 15) {
            HeaderSignin()
            ZStack(alignment: .trailing) {
            }
            Text("User name")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 25)
            
            CustomTextField(placeholder: "Masukkan user name Anda", text: $username, isSecure: false)
            
            Text("Email")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 25)
            
            CustomTextField(placeholder: "Masukkan email Anda", text: $email, isSecure: false)
            
            Text("Password")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 25)
            
            CustomTextField(placeholder: "Masukkan kata sandi", text: $password, isSecure: true)
            
            VStack(alignment: .leading) {
                        Text("Confirm Password")
                            .font(.headline)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 10)
                        
                        PasswordField(password: $password)
                    }
            
            
           
            
            Rectangle()
                .frame(height: 1) // Ketebalan garis
                .foregroundColor(.black) // Warna garis
                .frame(maxWidth: .infinity) // Lebar penuh
                .padding(.horizontal, 25)

            
            .padding(.horizontal, 25)
            
            PrimaryButton(title: "Daftar") {
                print("Login tapped")
            }
            
            
            .font(.footnote)
            
            Spacer()
        }
        .padding()
    }
}

// Perbaikan PreviewProvider
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
