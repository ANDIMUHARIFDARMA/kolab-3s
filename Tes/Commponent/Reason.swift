import SwiftUI

struct ReasonView: View {
    var reason: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "person.crop.circle.badge.questionmark")
                    Text("Alasan dari AI:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                    

                Text(reason)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray)
                .opacity(0.03)
                .overlay(
                            RoundedRectangle(cornerRadius: 15) // Sudut lengkung 15
                                .stroke(Color.orange, lineWidth: 1) // Warna border biru
                )
        )
        .frame(maxWidth: .infinity)
        .padding()    }
}

#Preview {
    ReasonView(reason: "C")
}
