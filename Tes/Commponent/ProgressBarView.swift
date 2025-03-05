import SwiftUI

struct ProgressBarView: View {
    var progress: Float
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressView(value: progress, total: 100)
                .progressViewStyle(LinearProgressViewStyle())
                .frame(maxWidth: .infinity)
                .padding()
                .accentColor(Color.orange)
        }
    }
}

#Preview {
    ProgressBarView(progress: 59)
}
