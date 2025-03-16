//
//  ProfileMenuItemView.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 06/03/25.
//

import SwiftUI

struct ProfileMenuItemView: View {
    let title: String
        let icon: String
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.orange)
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
        }
}

#Preview {
    ProfileMenuItemView(title: "Pengaturan", icon: "gearshape")
}

