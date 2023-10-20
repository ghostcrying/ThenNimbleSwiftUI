//
//  Refreshable.swift
//  Example
//
//  Created by 大大 on 2023/10/19.
//

import SwiftUI
import ThenNimbleSwiftUI

/// Callback that'll trigger once refreshing is done
public typealias RefreshComplete = () -> Void

/// The actual refresh action that's called once refreshing starts. It has the
/// RefreshComplete callback to let the refresh action let the View know
/// once it's done refreshing.
public typealias OnRefresh = (@escaping RefreshComplete) -> Void

/// The offset threshold. 68 is a good number, but you can play
/// with it to your liking.
public let defaultRefreshThreshold: CGFloat = 44

// MARK: - RefreshState

/// Tracks the state of the RefreshableScrollView - it's either:
/// 1. waiting for a scroll to happen
/// 2. has been primed by pulling down beyond THRESHOLD
/// 3. is doing the refreshing.
public enum RefreshState {
    case waiting
    case primed
    case loading
}

/// ViewBuilder for the custom progress View, that may render itself
/// based on the current RefreshState.
public typealias RefreshProgressBuilder<Progress: View> = (RefreshState, CGFloat) -> Progress

/// Default color of the rectangle behind the progress spinner
public let defaultLoadingViewBackgroundColor = Color(UIColor.systemBackground)

// MARK: - RefreshableScrollView

public struct RefreshableScrollView<Progress, Content>: View where Progress: View, Content: View {
    let showsIndicators: Bool // if the ScrollView should show indicators
    let shouldTriggerHapticFeedback: Bool // if key actions should trigger haptic feedback
    let loadingViewBackgroundColor: Color
    let threshold: CGFloat // what height do you have to pull down to trigger the refresh
    let onRefresh: OnRefresh // the refreshing action
    let progress: RefreshProgressBuilder<Progress> // custom progress view
    let content: () -> Content // the ScrollView content
    
    @State private var offset: CGFloat = 0
    @State private var state = RefreshState.waiting // the current state

    /// Haptic Feedback
    let finishedReloadingFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    let primedFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)

    /// We use a custom constructor to allow for usage of a @ViewBuilder for the content
    public init(
        showsIndicators: Bool = true,
        shouldTriggerHapticFeedback: Bool = false,
        loadingViewBackgroundColor: Color = defaultLoadingViewBackgroundColor,
        threshold: CGFloat = defaultRefreshThreshold,
        onRefresh: @escaping OnRefresh,
        @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.showsIndicators = showsIndicators
        self.shouldTriggerHapticFeedback = shouldTriggerHapticFeedback
        self.loadingViewBackgroundColor = loadingViewBackgroundColor
        self.threshold = threshold
        self.onRefresh = onRefresh
        self.progress = progress
        self.content = content
    }

    public var body: some View {
        // The root view is a regular ScrollView
        ScrollView(showsIndicators: self.showsIndicators) {
            // The ZStack allows us to position the PositionIndicator,
            // the content and the loading view, all on top of each other.
            ZStack(alignment: .top) {
                // The moving positioning indicator, that sits at the top
                // of the ScrollView and scrolls down with the content
                PositionIndicator(type: .moving)
                    .frame(height: 0)

                // Your ScrollView content. If we're loading, we want
                // to keep it below the loading view, hence the alignmentGuide.
                self.content()
                    .alignmentGuide(.top, computeValue: { _ in
                        (self.state == .loading) ? (max(0, self.offset) - self.threshold) : 0
                    })

                // The loading view. It's offset to the top of the content unless we're loading.
                ZStack {
                    Rectangle()
                        .foregroundColor(self.loadingViewBackgroundColor)
                        .frame(height: self.threshold)
                    self.progress(self.state, self.offset)
                }
                .offset(y: (self.state == .loading)
                        ? -max(0, self.offset)
                        : (self.state == .primed 
                           ? -self.offset
                           : -self.threshold))
            }
        }
        // Put a fixed PositionIndicator in the background so that we have
        // a reference point to compute the scroll offset.
        .background(PositionIndicator(type: .fixed))
        // Once the scrolling offset changes, we want to see if there should
        // be a state change.
        .onPreferenceChange(PositionPreferenceKey.self) { values in
            DispatchQueue.main.async {
                // Compute the offset between the moving and fixed PositionIndicators
                let movingY = values.first { $0.type == .moving }?.y ?? 0
                let fixedY = values.first { $0.type == .fixed }?.y ?? 0
                self.offset = movingY - fixedY
                if self.state != .loading { // If we're already loading, ignore everything
                    // Map the preference change action to the UI thread

                    // If the user pulled down below the threshold, prime the view
                    if self.offset > self.threshold && self.state == .waiting {
                        self.state = .primed
                        if self.shouldTriggerHapticFeedback {
                            self.primedFeedbackGenerator.impactOccurred()
                        }

                        // If the view is primed and we've crossed the threshold again on the
                        // way back, trigger the refresh
                    } else if self.offset < self.threshold && self.state == .primed {
                        self.state = .loading
                        self.onRefresh { // trigger the refreshing callback
                            // once refreshing is done, smoothly move the loading view
                            // back to the offset position
                            withAnimation {
                                self.state = .waiting
                            }
                            if self.shouldTriggerHapticFeedback {
                                self.finishedReloadingFeedbackGenerator.impactOccurred()
                            }
                        }
                    }
                }
            }
        }
    }
}

/// Extension that uses default RefreshActivityIndicator so that you don't have to
/// specify it every time.
public extension RefreshableScrollView where Progress == RefreshActivityIndicator {
    init(
        showsIndicators: Bool = true,
        loadingViewBackgroundColor: Color = defaultLoadingViewBackgroundColor,
        threshold: CGFloat = defaultRefreshThreshold,
        onRefresh: @escaping OnRefresh,
        @ViewBuilder content: @escaping () -> Content
    ) {
        func dealAlpha(state: RefreshState, offset: CGFloat, threshold: CGFloat) -> CGFloat {
            let alpha: CGFloat
            switch state {
            case .loading:
                alpha = 1
            case .waiting:
                alpha = 0
            default:
                //
                if offset < threshold {
                    alpha = 0
                } else {
                    if offset - threshold < threshold {
                        alpha = (offset - threshold) / threshold
                    } else {
                        alpha = 1
                    }
                }
                print("当前\(state) \(offset) \(threshold) 透明度: \(alpha)")
            }
            return alpha
        }
        self.init(
            showsIndicators: showsIndicators,
            loadingViewBackgroundColor: loadingViewBackgroundColor,
            threshold: threshold,
            onRefresh: onRefresh,
            progress: { state, offset in
                RefreshActivityIndicator(
                    isAnimating: state == .loading,
                    alpha: dealAlpha(state: state, offset: offset, threshold: threshold)
                ) { _ in
                    // $0.hidesWhenStopped = true
                }
            },
            content: content
        )
    }
}

#if compiler(>=5.5)
    /// Allows using RefreshableScrollView with an async block.
    @available(iOS 15.0, *)
    public extension RefreshableScrollView {
        init(
            showsIndicators: Bool = true,
            loadingViewBackgroundColor: Color = defaultLoadingViewBackgroundColor,
            threshold: CGFloat = defaultRefreshThreshold,
            action: @escaping @Sendable () async -> Void,
            @ViewBuilder progress: @escaping RefreshProgressBuilder<Progress>,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.init(
                showsIndicators: showsIndicators,
                loadingViewBackgroundColor: loadingViewBackgroundColor,
                threshold: threshold,
                onRefresh: { refreshComplete in
                    Task {
                        await action()
                        refreshComplete()
                    }
                },
                progress: progress,
                content: content
            )
        }
    }
#endif

// MARK: - TestView

struct Refreshable_View: View {
    @State private var now = Date()

    var body: some View {
        RefreshableScrollView(
            onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.now = Date()
                    done()
                }
            }) {
                VStack {
                    ForEach(1 ..< 5) { _ in
                        NavigationLink {
                            Text("++")
                        } label: {
                            Text("++").padding(.bottom, 10)
                        }
                        // Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: self.now)!)")
                    }
                }
                .padding()
            }
    }
}

// MARK: - TestViewWithLargerThreshold

struct RefreshableLargerThreshold_View: View {
    @State private var now = Date()

    var body: some View {
        RefreshableScrollView(
            threshold: defaultRefreshThreshold * 3,
            onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.now = Date()
                    done()
                }
            }
        ) {
            VStack {
                ForEach(1 ..< 20) {
                    Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: self.now)!)")
                        .padding(.bottom, 10)
                }
                Spacer()
            }.padding()
        }
    }
}

// MARK: - TestViewWithCustomProgress

struct RefreshableCustomProgress_View: View {
    @State private var now = Date()

    var body: some View {
        RefreshableScrollView(
            onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.now = Date()
                    done()
                }
            },
            progress: { state, offset in
//                if state == .waiting {
//                    Text("Pull me down...")
//                } else if state == .primed {
//                    Text("Now release!")
//                } else {
//                    Text("Working...")
//                }
                if state != .waiting {
                    ActivityIndicatorView(isVisible: .constant(true), type: .growingArc(lineWidth: 2))
                        .frame(width: 40, height: 40)
                }
                EmptyView()
            }
        ) {
            VStack {
                ForEach(1 ..< 20) {
                    Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: self.now)!)")
                        .padding(.bottom, 10)
                }
            }.padding()
        }
    }
}

// MARK: - Refreshable_Previews

struct Refreshable_Previews: PreviewProvider {
    static var previews: some View {
        Refreshable_View()
    }
}

// MARK: - RefreshableWithLargerThreshold_Previews

struct RefreshableWithLargerThreshold_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableLargerThreshold_View()
    }
}

// MARK: - RefreshableWithCustomProgress_Previews

struct RefreshableWithCustomProgress_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableCustomProgress_View()
    }
}

#if compiler(>=5.5)
    @available(iOS 15, *)
    struct RefreshableWithAsync_View: View {
        @State private var now = Date()

        var body: some View {
            RefreshableScrollView(action: {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                self.now = Date()
            }, progress: { state, offset in
                RefreshActivityIndicator(isAnimating: state == .loading, alpha: 1) {
                    $0.hidesWhenStopped = false
                }
            }) {
                VStack {
                    ForEach(1 ..< 20) {
                        Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: self.now)!)")
                            .padding(.bottom, 10)
                    }
                }.padding()
            }
        }
    }

    @available(iOS 15, *)
    struct RefreshableWithAsync_Previews: PreviewProvider {
        static var previews: some View {
            RefreshableWithAsync_View()
        }
    }
#endif
