import SwiftUI

struct SeitonProgressBar: View {
    var hairPoint: Float
    var clothingPoint: Float
    var facePoint: Float
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Nilai Per Kategori")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 10) {
                ProgressRow(category: "Rambut/Hijab", progress: hairPoint)
                ProgressRow(category: "Pakaian", progress: clothingPoint)
                ProgressRow(category: "Wajah", progress: facePoint)
            }
        }
        .padding(30)
    }
}

struct ProgressRow: View {
    var category: String
    var progress: Float
    
    var body: some View {
        HStack {
            Text(category)
                .frame(width: 120, alignment: .leading)
            ProgressView(value: progress / 100)
                .progressViewStyle(LinearProgressViewStyle())
                .frame(maxWidth: .infinity)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        SeitonProgressBar(hairPoint: 20, clothingPoint: 80, facePoint: 100)
    }
}
