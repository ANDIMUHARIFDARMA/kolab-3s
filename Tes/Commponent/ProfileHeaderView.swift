//
//  ProfileHeaderView.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 06/03/25.
//



import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Image("profile_picture") // Ganti dengan nama gambar di Assets
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.orange, lineWidth: 2))
                
                Button(action: {
                    print("Change Profile Picture")
                }) {
                    Image(systemName: "camera.fill")
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.orange)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }
                .offset(x: 35, y: 35)
            }
            
            Text("Parves Ahamad")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("@parvesahamad")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: {
                print("Edit Profile Button Tapped")
            }) {
                Text("Edit Profil")
                    .padding()
                    .frame(width: 150)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.7), Color.orange]), startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        }
        .padding()
    }
}


#Preview {
    ProfileHeaderView()
}
