//
//  ContentView.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 05/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Attendance")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)
                .padding(.bottom, 10)
            AttendanceCardView()
            
            ButtomAttendce()
            
            .padding(.horizontal)
            
            RecentActivityView()
            
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}
