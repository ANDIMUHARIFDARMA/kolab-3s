import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Image("Logo") // Pastikan nama file di Assets sesuai
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
            
            Text("Ko+Lab Center")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Versi 1.0.0")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(
            gradient: Gradient(colors: [Color.orange, Color.red]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ))
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = false
                }
            }
        }
    }
}
