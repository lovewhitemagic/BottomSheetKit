// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BottomSheetKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)   // ✅ 如果你要在 macOS 也支持
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
