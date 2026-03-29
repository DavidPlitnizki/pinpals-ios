import SwiftUI

struct PinRatingView: View {
    let rating: Int
    var maxRating: Int = 5
    var size: CGFloat = 12
    var onTap: ((Int) -> Void)?

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .font(.system(size: size))
                    .foregroundStyle(index <= rating ? Color.Pin.accentPrimary : Color.Pin.neutral200)
                    .onTapGesture {
                        onTap?(index)
                    }
            }
        }
    }
}

#Preview {
    VStack(spacing: PinSpacing.space4) {
        PinRatingView(rating: 0)
        PinRatingView(rating: 3)
        PinRatingView(rating: 5)
        PinRatingView(rating: 4, size: 20)
    }
    .padding()
    .background(Color.Pin.neutral50)
}
