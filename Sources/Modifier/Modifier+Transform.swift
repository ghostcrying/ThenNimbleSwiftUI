//
//  Modifier+Transform.swift
//  ThenNimbleSwiftUI
//
//  Created by 大大 on 2024/3/16.
//

import SwiftUI

/// https://stackoverflow.com/questions/68892142/swiftui-using-view-modifiers-between-different-ios-versions-without-available
public extension View {
    ///  eg:
    ///  Text("Good")
    ///      .modify {
    ///          if #available(iOS 15.0, *) {
    ///              $0.badge(2)
    ///          }
    ///      }
    @ViewBuilder
    func modify(@ViewBuilder _ transform: (Self) -> (some View)?) -> some View {
        if let view = transform(self), !(view is EmptyView) {
            view
        } else {
            self
        }
    }

    ///  eg:
    ///  Text("Good")
    ///      .modify {
    ///          if #available(iOS 15.0, *) {
    ///              $0.badge(2)
    ///          } else {
    ///              // Fallback on earlier versions
    ///          }
    ///      }
    func modify<Content>(@ViewBuilder _ transform: (Self) -> Content) -> Content {
        transform(self)
    }
}

/*: This way you should override methods, it's alittle tedious;

 struct Then<Content> {
   let content: Content
 }

 extension View {
   var backport: Then<Self> { Then(content: self) }
 }

 extension Then where Content: View {
   @ViewBuilder
   func badge(_ count: Int) -> some View {
     if #available(iOS 15, *) {
       content.badge(count)
     } else {
       self.content
     }
   }
 }
 */
