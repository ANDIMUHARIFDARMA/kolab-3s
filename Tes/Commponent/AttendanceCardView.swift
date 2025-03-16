import Foundation
import SwiftUI


struct AttendanceRecord: Identifiable {
    let id = UUID()
    let date: String
    let checkIn: String
    let checkOut: String
    let isPresent: Bool
}


struct AttendanceCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Monday, March 3, 2025")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            HStack(spacing: 8) {
                Image(systemName: "clock")
                    .foregroundColor(.gray)
                Text("11:49 AM")
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 8) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.gray)
                Text("Office Location")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}


#Preview {
    AttendanceCardView()
}
