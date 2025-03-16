//
//  HeaderLogin.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 05/03/25.
//

import SwiftUI

struct HeaderLogin: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("photos")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
            
            Text("Selamat Datang Kembali!")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Masuk ke akun Anda untuk melanjutkan")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    HeaderLogin()
}
