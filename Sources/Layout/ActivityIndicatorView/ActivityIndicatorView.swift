import SwiftUI

public struct ActivityIndicatorView: View {

    // MARK: - IndicatorType
    
    public enum IndicatorType {
        case `default`(count: Int = 8)
        case arcs(count: Int = 3, lineWidth: CGFloat = 2)
        case ballBeat(count: Int = 3, inset: Int = 4)
        case ballClipRotate(_ duration: Double = 0.75)
        case ballClipRotateMultiple(_ duration: Double = 0.75)
        case ballClipRotatePulse(_ duration: Double = 0.75)
        case ballGridBeat
        case ballGridPulse
        case ballPulse(count: Int = 3, inset: Int = 2)
        case ballPulseRise(_ duration: Double = 1)
        case ballPulseSync(_ duration: Double = 0.6)
        case ballRotate(_ duration: Double = 0.6)
        case ballRotateChase(count: Int = 5)
        case ballScale(_ duration: Double = 1)
        case ballScaleMultiple(_ duration: Double = 1)
        case ballScaleRipple(_ duration: Double = 1)
        case ballScaleRippleMultiple(_ duration: Double = 1)
        case ballSpinFadeLoader(count: Int = 8)
        case ballTrianglePath(_ duration: Double = 1.5)
        case ballZigZag(_ duration: Double = 0.25)
        case ballZigZagDeflect(_ duration: Double = 0.25)
        case circlePendulum(_ duration: Double = 1)
        case equalizer(count: Int = 5)
        case growingArc(Color = .black, lineWidth: CGFloat = 4)
        case gradient(_ colors: [Color], CGLineCap = .butt, lineWidth: CGFloat = 4)
        case pacman(_ duration: Double = 0.5)
        case orbit(_ duration: Double = 2.0)
        case newtonCradle(_ duration: Double = 0.25)
    }

    @Binding var isVisible: Bool
    var type: IndicatorType

    // MARK: - Public
    public init(isVisible: Binding<Bool>, type: IndicatorType) {
        _isVisible = isVisible
        self.type = type
    }

    public var body: some View {
        if isVisible {
            indicator
        } else {
            EmptyView()
        }
    }
    
    
    // MARK: - Private
    
    private var indicator: some View {
        ZStack {
            switch type {
            case .default(let count):
                DefaultIndicatorView(count: count)
            case .arcs(let count, let lineWidth):
                ArcsIndicatorView(count: count, lineWidth: lineWidth)
            case .ballRotateChase(let count):
                BallRotateChaseIndicatorView(count: count)
            case .ballSpinFadeLoader(let count):
                BallSpinFadeLoaderIndicatorView(count: count)
            
            case .ballBeat(let count, let inset):
                BallBeatIndicatorView(count: count, inset: inset)
            case .ballClipRotate(let duration):
                BallClipRotateIndicatorView(duration: duration)
            case .ballClipRotateMultiple(let duration):
                BallClipRotateMultipleIndicatorView(duration: duration)
            case .ballClipRotatePulse(let duration):
                BallClipRotatePulseIndicatorView(duration: duration)
            case .ballGridBeat:
                BallGridBeatIndicatorView()
            case .ballGridPulse:
                BallGridPulseIndicatorView()
            case .ballPulse(let count, let inset):
                BallPulseIndicatorView(count: count, inset: inset)
            case .ballPulseRise(let duration):
                BallPulseRiseIndicatorView(duration: duration)
            case .ballPulseSync(let duration):
                BallPulseSyncIndicatorView(duration: duration)
            case .ballRotate(let duration):
                BallRotateIndicatorView(duration: duration)
            case .ballScale(let duration):
                BallScaleIndicatorView(duration: duration)
            case .ballScaleMultiple(let duration):
                BallScaleMultipleIndicatorView(duration: duration)
            case .ballScaleRipple(let duration):
                BallScaleRippleIndicatorView(duration: duration)
            case .ballScaleRippleMultiple(let duration):
                BallScaleRippleMultipleIndicatorView(duration: duration)
            case .ballTrianglePath(let duration):
                BallTrianglePathIndicatorView(duration: duration)
            case .ballZigZag(let duration):
                BallZigZagIndicatorView(duration: duration)
            case .ballZigZagDeflect(let duration):
                BallZigZagDeflectIndicatorView(duration: duration)
                
            case .equalizer(let count):
                EqualizerIndicatorView(count: count)
            case .growingArc(let color, let lineWidth):
                GrowingArcIndicatorView(color: color, lineWidth: lineWidth)
            case .gradient(let colors, let lineCap, let lineWidth):
                GradientIndicatorView(colors: colors, lineCap: lineCap, lineWidth: lineWidth)
            case .newtonCradle(let duration):
                NewtonCradleIndicatorView(duration: duration)
            case .circlePendulum(let duration):
                CirclePendulumIndicatorView(duration: duration)
            case .pacman(let duration):
                PacmanIndicatorView(duration: duration)
            case .orbit(let duration):
                OrbitIndicatorView(duration: duration)
            }
        }
    }
}
