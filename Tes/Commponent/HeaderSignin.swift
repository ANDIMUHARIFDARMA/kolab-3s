//
//  HeaderSignin.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 06/03/25.
//

import SwiftUI

struct HeaderSignin: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("photos")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
            
            Text("Kolab Center")
                .font(.largeTitle).bold()
            
            Text("Silahkan daftarkan diri anda!")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Silahkan isi data di bawah")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    HeaderSignin()
}
