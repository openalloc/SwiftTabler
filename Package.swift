// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftTabler",
    platforms: [.macOS("11.0"), .iOS("14.0")],
    products: [
        .library(name: "Tabler", targets: ["Tabler"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Tabler",
            dependencies: [],
            path: "Sources"
        ),
//        .testTarget(
//            name: "TablerTests",
//            dependencies: [
//                "Tabler",
//            ],
//            path: "Tests"
//        ),
    ]
)
