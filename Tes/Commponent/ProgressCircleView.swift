import SwiftUI

struct ProgressCircleView: View {
    var rating: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundColor(.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(rating) / 100)
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .foregroundColor(.orange)
                .rotationEffect(Angle(degrees: -90))
            
            Text("\(rating) Pts")
                .font(.title)
                .bold()
        }
        .frame(width: 150, height: 150)
        .padding(.top, 70)
    }
}

#Preview {
    ProgressCircleView(rating: 85)
}
