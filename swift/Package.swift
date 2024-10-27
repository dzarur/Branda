// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS", from: "6.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GoogleSignInApp",
            dependencies: ["GoogleSignIn"]),
        .testTarget(
            name: "GoogleSignInAppTests",
            dependencies: ["GoogleSignInApp"]),
        .executableTarget(
            name: "swift",
            dependencies: []),
    ]
)
