//
//  RefreshExample.swift
//  Example
//
//  Created by 大大 on 2023/10/25.
//

import SwiftUI
import ThenNimbleSwiftUI

struct RefreshExample: View {
    var body: some View {
        List {
            Section {
                NavigationLink { RefreshDefaultView() } label: {
                    Text("Default")
                }
                
                NavigationLink { RefreshProgressView() } label: {
                    Text("Progress")
                }
                
                NavigationLink { RefreshCompactView() } label: {
                    Text("Compact")
                }
                        
                if #available(iOS 15.0, *) {
                    NavigationLink { listRefresh } label: {
                        Text("System")
                    }
                }
                
            } header: {
                Text("🐿️")
            }
        }
        .navigationTitle("Nimble UI")
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

#Preview {
    RefreshExample()
}
