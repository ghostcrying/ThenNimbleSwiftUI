//
//  ContentView.swift
//  Example
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - ContentView

struct ContentView: View {
    @State var angle: Double = 0

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink { self.testAnimate.navigationTitle("Testing") } label: {
                        Text("测试")
                    }

                    NavigationLink {
                        RefreshExample()
                            .navigationTitle("refreshable")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text("refreshable")
                    }
                } header: {
                    Text("🐿️")
                }

                Section {
                    NavigationLink { ActivityIndicatorViewExample().navigationTitle("动画") } label: {
                        Text("菊花")
                    }
                } header: {
                    Text("🌾")
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
                .rotationEffect(.degrees(self.angle))
        }
        .onAnimationCompleted(for: self.angle, completion: {
            print(Date())
        })
        .onAppear {
            withAnimation(.linear(duration: 1).repeatForever()) {
                self.angle = 100
            }
        }
    }
}
