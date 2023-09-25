import SwiftUI

struct BallSpinFadeLoaderIndicatorViewExample_Previews: PreviewProvider {
    static var previews: some View {
        BallSpinFadeLoaderIndicatorView(count: 7)
            .frame(width: 100, height: 100)
        
        BallSpinFadeLoaderIndicatorItemView(index: 0, count: 8, size: CGSize(width: 100, height: 100))
    }
}


struct BallSpinFadeLoaderIndicatorView: View {

    let count: Int

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<count, id: \.self) { index in
                BallSpinFadeLoaderIndicatorItemView(index: index, count: count, size: geometry.size)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct BallSpinFadeLoaderIndicatorItemView: View {

    let index: Int
    let count: Int
    let size: CGSize

    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0

    var body: some View {
        let duration = 0.5
        let itemSize = size.height / 5
        let angle = 2 * CGFloat.pi / CGFloat(count) * CGFloat(index) - CGFloat.pi / 2
        let x = (size.width / 2 - itemSize / 2) * cos(angle)
        let y = (size.height / 2 - itemSize / 2) * sin(angle)

        let animation = Animation.linear(duration: duration)
            .repeatForever(autoreverses: true)
            .delay(duration * Double(index) / Double(count) * 2)

        return Circle()
            .frame(width: itemSize, height: itemSize)
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                scale = 1
                opacity = 1
                withAnimation(animation) {
                    scale = 0.5
                    opacity = 0.3
                }
            }
            .offset(x: x, y: y)
    }
}
