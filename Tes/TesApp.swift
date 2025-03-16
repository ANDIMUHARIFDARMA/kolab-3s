//
//  TesApp.swift
//  Tes
//
//  Created by ANDISAPUTRA on 04/03/25.
//

import SwiftUI

@main
struct TesApp: App {
    @State private var isActive: Bool = true
    @AppStorage("userToken") private var userToken: String?
    @AppStorage("userData") private var userData: String?
    
    var body: some Scene {
        WindowGroup {
            if(isActive){
                SplashScreenView(isActive: $isActive)
            } else {
                if userToken == nil || userData == nil {
                    LoginView()
                } else {
                    BottomNavBar()
                }
            }
        }
    }
}
