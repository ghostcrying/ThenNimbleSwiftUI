import SwiftUI

struct DefaultIndicatorViewExample_Previews: PreviewProvider {
    static var previews: some View {
        DefaultIndicatorView(count: 7)
            .frame(width: 100, height: 100)
        
        DefaultIndicatorItemView(index: 0, count: 8, size: CGSize(width: 100, height: 100))
    }
}


struct DefaultIndicatorView: View {

    let count: Int

    public var body: some View {
        GeometryReader { geometry in
            ForEach(0..<count, id: \.self) { index in
                DefaultIndicatorItemView(index: index, count: count, size: geometry.size)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct DefaultIndicatorItemView: View {

    let index: Int
    let count: Int
    let size: CGSize

    @State private var opacity: Double = 0

    var body: some View {
        let height = size.height / 3.2
        let width = height / 2
        /// 第一个始终在最上方
        let angle: Double = 2 * .pi / Double(count) * Double(index)
        let x = (size.width / 2 - height / 2) * cos(angle)
        let y = (size.height / 2 - height / 2) * sin(angle)

        let animation = Animation.default
            .repeatForever(autoreverses: true)
            .delay(Double(index) / Double(count) / 2)

        return RoundedRectangle(cornerRadius: width / 2 + 1)
            .frame(width: width, height: height)
            .rotationEffect(Angle(radians: angle + .pi / 2))
            .offset(x: x, y: y)
            .opacity(opacity)
            .onAppear {
                opacity = 1
                withAnimation(animation) {
                    opacity = 0.3
                }
            }
    }
}
