import SwiftUI

struct BallScaleIndicatorViewExample_Previews: PreviewProvider {
    static var previews: some View {
        BallScaleIndicatorView()
            .frame(width: 100, height: 100)
    }
}

struct BallScaleIndicatorView: View {

    var duration: Double = 1
    
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0

    var body: some View {
        let animation = Animation
            .easeIn(duration: duration)
            .repeatForever(autoreverses: false)

        return Circle()
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                scale = 0
                opacity = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation(animation) {
                        scale = 1
                        opacity = 0
                    }
                }
            }
    }
}
