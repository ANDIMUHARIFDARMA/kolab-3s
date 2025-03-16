//
//  ProfileView.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 06/03/25.
//

import SwiftUI

struct ProfileViewPage: View {
    var body: some View {
        ProfileHeaderView()
        ProfileMenuItemView(title: "Ubah Pasword", icon: "gearshape")
       
        Spacer()
        PrimaryButton(title: "Keluar"){
            print("Button tapped")
        }
        
    }
}

#Preview {
    ProfileViewPage()
}
