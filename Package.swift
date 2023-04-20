// swift-tools-version: 5.7

// Copyright 2021, 2022 OpenAlloc LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

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
