// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/// `    public init(name: String, dependencies: [PackageDescription.Package.Dependency] = [], targets: [PackageDescription.Target] = [])`
let package = Package(
    name: "myFirstVaporApp",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "myFirstVaporApp",
            targets: ["myFirstVaporApp"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        /// `    public static func package(url: String, from version: PackageDescription.Version) -> PackageDescription.Package.Dependency`
        /// 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        
        // SE-0294, "Declaring executable targets in Package Manifests
        /// https://forums.swift.org/t/se-0294-declaring-executable-targets-in-package-manifests/42404
        .executableTarget(
            name: "myFirstVaporApp",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ]
        ),
        .testTarget(
            name: "myFirstVaporAppTests",
            dependencies: ["myFirstVaporApp"]
        ),
    ]
)
