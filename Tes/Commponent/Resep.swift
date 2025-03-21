import SwiftUI

struct ResepView: View {
    var steps: [String]
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "character.book.closed.fill")
                    Text("Langkah - langkah membuatnya:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                    
                ForEach(Array(steps.enumerated()), id: \.element) { index, step in
                    Text("\(index + 1). \(step)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
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
    ResepView(steps: ["Tes"])
}
