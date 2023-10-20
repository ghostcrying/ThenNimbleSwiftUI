//
//  AutosizingList.swift
//  ThenNimbleSwiftUI
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI
import SwiftUIIntrospect

#if os(iOS)
public struct AutosizingList<Content: View>: View {
    
    var content: Content
    
    @State private var observation: NSKeyValueObservation?
    @State private var tableContentHeight: CGFloat = 0.0
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        List {
            content
        }        
        .introspect(.list, on: .iOS(.v13, .v14, .v15), customize: { tableView in
            tableView.backgroundColor = .clear
            tableView.isScrollEnabled = false
            tableContentHeight = tableView.contentSize.height
            observation = tableView.observe(\.contentSize) { tableView, value in
                tableContentHeight = tableView.contentSize.height
            }
        })
        .frame(height: tableContentHeight)
    }
    
}
#endif
