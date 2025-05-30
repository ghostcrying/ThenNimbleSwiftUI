// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThenNimbleSwiftUI",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ThenNimbleSwiftUI",
            targets: ["ThenNimbleSwiftUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: "https://github.com/siteline/swiftui-introspect", from: "0.10.0"),
        .package(path: "Packages/swiftui-introspect")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ThenNimbleSwiftUI",    
            dependencies: [
                .product(name: "SwiftUIIntrospect", package: "swiftui-introspect"),
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "ThenNimbleSwiftUITests",
            dependencies: ["ThenNimbleSwiftUI"]),
    ]
)
