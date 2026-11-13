// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "refiner_flutter",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "refiner-flutter", type: .static, targets: ["refiner_flutter"])
    ],
    dependencies: [
        .package(url: "https://github.com/refiner-io/mobile-sdk-ios.git", from: "2.1.0")
    ],
    targets: [
        .target(
            name: "refiner_flutter",
            dependencies: [
                .product(name: "RefinerSDK", package: "mobile-sdk-ios")
            ]
        )
    ]
)
