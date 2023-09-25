//
//  ActivityIndicatorViewExample.swift
//  Example
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI
import ThenNimbleSwiftUI

struct ActivityIndicatorViewExample: View {
    
    @State private var showLoadingIndicator: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width / 5
            let spacing: CGFloat = 40.0
            
            ScrollView {
                HStack {
                    
                    VStack(spacing: spacing) {
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballClipRotateMultiple())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballClipRotatePulse())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballGridBeat)
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballGridPulse)
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballPulse())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballPulseRise())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballPulseSync())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballRotate())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballRotateChase())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: spacing) {
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballScaleMultiple())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballScaleRipple())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballScaleRippleMultiple())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballSpinFadeLoader())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballTrianglePath())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballZigZag())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .ballZigZagDeflect())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .circlePendulum())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .equalizer())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                        ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .growingArc())
                            .frame(width: size, height: size)
                            .foregroundColor(.red)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ActivityIndicatorViewExample_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorViewExample()
    }
}
