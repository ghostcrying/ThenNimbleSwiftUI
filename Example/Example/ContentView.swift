//
//  ContentView.swift
//  Example
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    
    @State var angle: Double = 0

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink { testAnimate.navigationTitle("Testing") } label: {
                        Text("测试")
                    }

                    NavigationLink {
                        Refreshable_View()
                            .navigationTitle("refreshable")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text("refreshable")
                    }
                    
                    NavigationLink { RefreshableCustomProgress_View() } label: {
                        Text("refreshable custom progress")
                    }
                    
                    NavigationLink { RefreshableCompat_View() } label: {
                        Text("refreshable quick")
                    }
                    
                    NavigationLink { listRefresh_Cus } label: {
                        Text("T1")
                    }
                    
                    if #available(iOS 15.0, *) {
                        NavigationLink { listRefresh } label: {
                            Text("T2")
                        }
                    }
                } header: {
                    Text("🐿️")
                }
            }
            .navigationTitle("Nimble UI")
        }
    }
    
    var testAnimate: some View {
        VStack {
            Rectangle()
                .fill()
                .frame(width: 100, height: 10)
                .rotationEffect(.degrees(angle))
        }
        .onAnimationCompleted(for: angle, completion: {
            print(Date())
        })
        .onAppear {
            withAnimation(.linear(duration: 1).repeatForever()) {
                angle = 100
            }
        }

    }
    
    var listRefresh_Cus: some View {
        List {
            ForEach(0 ..< 5) { _ in
                Text("++").padding(.bottom, 10)
            }
        }
        .refreshableCompat(
            showsIndicators: false,
            onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    done()
                }
            },
            progress: { state, offset in
                if state != .waiting {
                    RefreshActivityIndicator(isAnimating: state == .loading, alpha: 1) {
                        $0.hidesWhenStopped = false
                    }
                }
                EmptyView()
            }
        )
        .navigationTitle("T1")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @available(iOS 15.0, *)
    var listRefresh: some View {
        List {
            ForEach(0 ..< 5) { _ in
                Text("++").padding(.bottom, 10)
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            await withCheckedContinuation { cont in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    cont.resume()
                }
            }
        }
        .navigationTitle("T2")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}
