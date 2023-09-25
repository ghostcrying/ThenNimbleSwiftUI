//
//  ScaleScollExample.swift
//  Example
//
//  Created by 陈卓 on 2023/8/7.
//

import SwiftUI
#if os(iOS)
import ThenNimbleSwiftUI

struct ScaleScollExample_Previews: PreviewProvider {
    static var previews: some View {
        ScaleScollExample()
    }
}

struct ScaleScollExample: View {
    @Environment(\.presentationMode) var presentationMode

    @State var simplePresented = false
    @State var mapPresented = false
    @State var colorPresented = false
    @State var requestPresented = false
    @State var tabPresented = false
    @State var profilePresented = false
    @State var bankingPresented = false
    @State var bookingPresented = false
    
    var body: some View {
        List {
            Section(header: Text("Simple Examples")) {
                ScaleScrollExampleItemView(isPresented: $simplePresented, name: "Simple Scaling Header") {
                    SimpleScalingHeader()
                }

                ScaleScrollExampleItemView(isPresented: $mapPresented, name: "Map Scaling Header") {
                    MapScalingHeader()
                }

                ScaleScrollExampleItemView(isPresented: $colorPresented, name: "Color Scaling Header") {
                    ColorScalingHeader()
                }

                ScaleScrollExampleItemView(isPresented: $requestPresented, name: "Request Scaling Header") {
                    RequestScalingHeader()
                }

                ScaleScrollExampleItemView(isPresented: $tabPresented, name: "Tab Scaling Header") {
                    TabScalingHeader()
                }
            }

            Section(header: Text("Beautiful Examples")) {
                ScaleScrollExampleItemView(isPresented: $profilePresented, name: "Profile Screen") {
                    ProfileScreen()
                }

                ScaleScrollExampleItemView(isPresented: $bookingPresented, name: "Booking Screen") {
                    BookingScreen()
                }

                ScaleScrollExampleItemView(isPresented: $bankingPresented, name: "Banking Screen") {
                    BankingScreen()
                }
            }
        }
        .listStyle(.grouped)
    }
}

struct ScaleScrollExampleItemView<Content: View>: View {

    @Binding var isPresented: Bool
    var name: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        Button(name) {
            isPresented = true
        }
        .fullScreenCover(isPresented: $isPresented) {
            content()
        }
    }
}
#endif
