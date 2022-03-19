// swift-tools-version:5.3

import PackageDescription

let pkg = Package(name: "PMKFoundationPackage")
pkg.products = [
    .library(name: "PMKFoundation2", targets: ["PMKFoundation2"]),
]
pkg.dependencies = [
    .package(url: "https://github.com/mxcl/PromiseKit", .exactItem("7.0.0-rc2"))
]

pkg.swiftLanguageVersions = [.v4, .v4_2, .v5]

let target: Target = .target(name: "PMKFoundation2")
target.path = "Sources"
target.exclude = ["NSNotificationCenter", "NSTask", "NSURLSession"].flatMap {
    ["\($0)+AnyPromise.m", "\($0)+AnyPromise.h"]
}
target.exclude.append("PMKFoundation.h")

target.dependencies = [
    "PromiseKit"
]

#if os(Linux)
target.exclude += [
    "afterlife.swift",
    "NSObject+Promise.swift"
]
#endif

pkg.targets = [target]

pkg.platforms = [
   .macOS(.v10_12), .iOS(.v13), .tvOS(.v9), .watchOS(.v2)
]
