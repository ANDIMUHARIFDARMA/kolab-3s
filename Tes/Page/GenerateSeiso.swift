import SwiftUI

struct GenerateSeiso: View {
    var suggestion: String?
    var rating: Int?
    var reason :String?
    var hairPoint: Float?
    var clothingPoint: Float?
    var facePoint: Float?

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ProgressCircleView(rating: rating ?? 0)
            SeitonProgressBar(hairPoint: hairPoint ?? 0, clothingPoint: clothingPoint ?? 0, facePoint: facePoint ?? 0)
            ReasonView(reason: reason ?? "")
            SuggestionView(suggestion: suggestion ?? "")
            Spacer()
        }
        .frame(width: .infinity)
    }
}

#Preview {
    GenerateSeiso(suggestion: "Tes", rating: 85)
}
