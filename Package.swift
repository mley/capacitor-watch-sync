// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorWatchSync",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorWatchSync",
            targets: ["WatchSyncPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "WatchSyncPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/WatchSyncPlugin"),
        .testTarget(
            name: "WatchSyncPluginTests",
            dependencies: ["WatchSyncPlugin"],
            path: "ios/Tests/WatchSyncPluginTests")
    ]
)