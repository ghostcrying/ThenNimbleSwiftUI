//
//  RefreshableCompat.swift
//  Example
//
//  Created by 大大 on 2023/10/19.
//

import SwiftUI

// MARK: - RefreshableCompat

public struct RefreshableCompat<Progress>: ViewModifier where Progress: View {
    private let showsIndicators: Bool
    private let loadingViewBackgroundColor: Color
    private let threshold: CGFloat
    private let onRefresh: OnRefresh
    private let progress: RefreshProgressBuilder<Progress>

    public init(
        showsIndicators: Bool = true,
        loadingViewBackgroundColor: Color = defaultLoadingViewBackgroundColor,
        threshold: CGFloat = defaultRefreshThreshold,
        onRefresh: @escaping OnRefresh,
        @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>
    ) {
        self.showsIndicators = showsIndicators
        self.loadingViewBackgroundColor = loadingViewBackgroundColor
        self.threshold = threshold
        self.onRefresh = onRefresh
        self.progress = progress
    }

    public func body(content: Content) -> some View {
        RefreshableScrollView(
            showsIndicators: self.showsIndicators,
            loadingViewBackgroundColor: self.loadingViewBackgroundColor,
            threshold: self.threshold,
            onRefresh: self.onRefresh,
            progress: self.progress
        ) {
            content
        }
    }
}

#if compiler(>=5.5)
    @available(iOS 13.0, *)
    public extension List {
        @ViewBuilder
        func refreshableCompat<Progress: View>(
            showsIndicators: Bool = true,
            loadingViewBackgroundColor: Color = defaultLoadingViewBackgroundColor,
            threshold: CGFloat = defaultRefreshThreshold,
            onRefresh: @escaping OnRefresh,
            @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>
        ) -> some View {
            if #available(iOS 15.0, macOS 12.0, *) {
                self.refreshable {
                    await withCheckedContinuation { cont in
                        onRefresh {
                            cont.resume()
                        }
                    }
                }
            } else {
                self.modifier(RefreshableCompat(
                    showsIndicators: showsIndicators,
                    loadingViewBackgroundColor: loadingViewBackgroundColor,
                    threshold: threshold,
                    onRefresh: onRefresh,
                    progress: progress
                ))
            }
        }
    }
#endif

public extension View {
    @ViewBuilder
    func refreshableCompat<Progress: View>(
        showsIndicators: Bool = true,
        loadingViewBackgroundColor: Color = defaultLoadingViewBackgroundColor,
        threshold: CGFloat = defaultRefreshThreshold,
        onRefresh: @escaping OnRefresh,
        @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>
    ) -> some View {
        self.modifier(RefreshableCompat(
            showsIndicators: showsIndicators,
            loadingViewBackgroundColor: loadingViewBackgroundColor,
            threshold: threshold,
            onRefresh: onRefresh,
            progress: progress
        ))
    }
}


// MARK: - TestViewCompat

struct RefreshableCompat_View: View {
    @State private var now = Date()

    var body: some View {
        VStack {
            ForEach(1 ..< 5) {
                Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: self.now)!)")
                    .padding(.bottom, 10)
            }
        }
        .refreshableCompat(
            showsIndicators: false,
            onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.now = Date()
                    done()
                }
            },
            progress: { state, offset in
                ActivityIndicatorView(isVisible: .constant(true), type: .default())
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
            }
        )
    }
}


// MARK: - TestViewCompat_Previews

struct TestViewCompat_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableCompat_View()
    }
}
