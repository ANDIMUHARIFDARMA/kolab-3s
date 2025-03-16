//
//  UbahProfile.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 06/03/25.
//

import SwiftUI

struct UbahProfile: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    var onBack: () -> Void
    
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button(action: {
                    onBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                Spacer()
                Text("Edit Profile")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            Spacer(minLength: 10)
            
           
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
            
            Spacer()
            
            .padding(.horizontal, 25)
            
            PrimaryButton(title: "Ubah") {
                print("ubah profile tapped")
            }
            
            
            .font(.footnote)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    UbahProfile(){
        print("Back button tapped")
    }
}

