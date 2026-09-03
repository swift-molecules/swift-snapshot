// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-snapshot",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Snapshot",
            targets: ["Snapshot"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-sequence.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "Snapshot",
            dependencies: [
                .product(name: "Sequence Difference", package: "swift-sequence")
            ],
            path: "Sources/Snapshot"
        ),
        .testTarget(
            name: "Snapshot Tests",
            dependencies: [
            ],
            path: "Tests/Snapshot Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
