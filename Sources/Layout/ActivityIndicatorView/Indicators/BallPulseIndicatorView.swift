import SwiftUI

struct BallPulseIndicatorViewExample_Previews: PreviewProvider {
    static var previews: some View {
        BallPulseIndicatorView(count: 4, inset: 5)
            .frame(width: 100, height: 100)
    }
}

struct BallPulseIndicatorView: View {

    let count: Int
    let inset: Int

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<count, id: \.self) { index in
                BallPulseIndicatorItemView(index: index, count: count, inset: inset, size: geometry.size)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct BallPulseIndicatorItemView: View {

    let index: Int
    let count: Int
    let inset: Int
    let size: CGSize

    @State private var scale: CGFloat = 0

    var body: some View {
        let itemSize = (size.width - CGFloat(inset) * CGFloat(count - 1)) / CGFloat(count)

        let animation = Animation.easeOut
            .repeatForever(autoreverses: true)
            .delay(Double(index) / Double(count) / 2)
        
        return Circle()
            .frame(width: itemSize, height: itemSize)
            .scaleEffect(scale)
            .onAppear {
                scale = 1
                withAnimation(animation) {
                    scale = 0.3
                }
            }
            .offset(x: (itemSize + CGFloat(inset)) * CGFloat(index) - size.width / 2 + itemSize / 2)
    }
}
