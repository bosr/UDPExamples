import PackageDescription

let package = Package(
    name: "UDPExamples",
    dependencies: [
        .Package(url: "https://github.com/VeniceX/UDP.git", majorVersion: 0, minor: 13)
    ]
)
