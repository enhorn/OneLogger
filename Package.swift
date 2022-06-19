// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneLogger",
    platforms: [
        .macOS(.v11),
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "OneLogger",
            targets: ["OneLogger"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "OneLogger",
            dependencies: [],
            exclude: ["../../Demo"]
        ),
        .testTarget(
            name: "OneLoggerTests",
            dependencies: ["OneLogger"]
        ),
    ]
)
