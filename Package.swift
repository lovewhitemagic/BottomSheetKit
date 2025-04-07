// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BottomSheetKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "BottomSheetKit", targets: ["BottomSheetKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BottomSheetKit",
            dependencies: []
        )
    ]
)