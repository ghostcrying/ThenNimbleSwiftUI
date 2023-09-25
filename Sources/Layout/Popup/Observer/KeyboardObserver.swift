//
//  KeyboardObserver.swift
//  
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI

#if os(iOS)

class KeyboardObserver: ObservableObject {

    @Published var keyboardHeight: CGFloat = 0
    @Published var keyboardDisplayed: Bool = false

    init() {
        self.listenForKeyboardNotifications()
    }

    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

            self.keyboardHeight = keyboardRect.height
            self.keyboardDisplayed = true
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            self.keyboardHeight = 0
            self.keyboardDisplayed = false
        }
    }
}

#else

class KeyboardObserver: ObservableObject {

    @Published var keyboardHeight: CGFloat = 0
    @Published var keyboardDisplayed: Bool = false
}

#endif
