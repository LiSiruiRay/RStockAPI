// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RStockAPI",
    platforms: [.macOS(.v12), .iOS(.v13), .watchOS(.v8), .tvOS(.v13)],
    products: [
        .library(
            name: "RStockAPI",
            targets: ["RStockAPI"]),
        .executable(name: "StocksAPIExec", targets: ["StocksAPIExec"])
    ],
    targets: [
        .target(
            name: "RStockAPI",
            dependencies: []),
        .executableTarget(name: "StocksAPIExec",
                         dependencies: ["RStockAPI"]),
        .testTarget(
            name: "RStockAPITests",
            dependencies: ["RStockAPI"]),
    ]
)
