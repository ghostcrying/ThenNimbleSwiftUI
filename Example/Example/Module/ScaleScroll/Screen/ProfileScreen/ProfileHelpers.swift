import SwiftUI
#if os(iOS)
import ThenNimbleSwiftUI

struct HireButtonStyle: ButtonStyle {

    var foreground = Color.white

    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color(hex: "#374BFE"))
            .overlay(configuration.label.foregroundColor(foreground))
    }
}

struct VisualEffectView: UIViewRepresentable {

    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
#endif
