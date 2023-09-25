import SwiftUI

struct NewtonCradleIndicatorView: View {

    var duration: Double = 0.25
    
    private let ballCount: Int = 5
    private let ratio: CGFloat = 7
    
    @State private var leftsAnimate: Bool = true
    @State private var rightAnimate: Bool = true
            
    var body: some View {
        GeometryReader { geometry in
            let w = geometry.size.width / ratio
            let h = geometry.size.height - w
            let offset = geometry.size.width / 2 - w / 2
            ZStack(alignment: .center) {
                ForEach(0..<5, id: \.self) { index in
                    Circle()
                        .fill()
                        .frame(width: w, height: w)
                        .offset(x: w * (CGFloat(index) - 2), y: h)
                        .rotationEffect(roatationAngle(index: index))
                }
                .offset(x: offset)
            }
        }
        .onAppear {
            let easeInQuad = Animation.timingCurve(0.55, 0.085, 0.68, 0.53, duration: duration)
            let easeOutQuad = Animation.timingCurve(0.25, 0.46, 0.45, 0.94, duration: duration)
            Timer.scheduledTimer(withTimeInterval: duration * 4, repeats: true) { timer in
                withAnimation(easeOutQuad) {
                    leftsAnimate.toggle()
                }
                withAnimation(easeInQuad.delay(duration * 1)) {
                    leftsAnimate.toggle()
                }
                withAnimation(easeOutQuad.delay(duration * 2)) {
                    rightAnimate.toggle()
                }
                withAnimation(easeInQuad.delay(duration * 3)) {
                    rightAnimate.toggle()
                }
            }.fire()
        }
    }
    
    private func roatationAngle(index: Int) -> Angle {
        switch index {
        case 0:
            return Angle(degrees: leftsAnimate ? 0 : 60)
        case 4:
            return Angle(degrees: rightAnimate ? 0 : -60)
        default:
            return Angle()
        }
    }
}

struct NewtonCradleIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        NewtonCradleIndicatorView()
            .frame(width: 100, height: 100)
    }
}
