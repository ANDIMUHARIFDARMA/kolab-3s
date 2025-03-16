//
//  RecentActivityItemView.swift
//  Kolab Center
//
//  Created by ANDISAPUTRA on 05/03/25.
//

import SwiftUI

struct RecentActivityView: View {
    let records: [AttendanceRecord] = [
        AttendanceRecord(date: "February 15, 2024", checkIn: "09:00 AM", checkOut: "06:00 PM", isPresent: true),
        AttendanceRecord(date: "February 14, 2024", checkIn: "08:55 AM", checkOut: "06:05 PM", isPresent: true),
        AttendanceRecord(date: "February 13, 2024", checkIn: "09:02 AM", checkOut: "06:00 PM", isPresent: true)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Activity")
                .font(.headline)
                
                .padding(.vertical, 20)
                .padding(.horizontal, 15)

            
            ForEach(records) { record in
                RecentActivityItemView(record: record)
            }
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}
struct RecentActivityItemView: View {
    let record: AttendanceRecord
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                
                
                Text(record.date)
                    .fontWeight(.semibold)
                    .padding(.vertical, 5)
                
                Spacer()
                
                if record.isPresent {
                    Label("Present", systemImage: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.footnote)
                }
            }
            
            HStack {
                
                Text("Check-in: \(record.checkIn)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.vertical, 5)
                
                Spacer()
                
                Text("Check-out: \(record.checkOut)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Divider()
        }
        .padding(.horizontal)
    }
}

#Preview {
    RecentActivityView()
}
