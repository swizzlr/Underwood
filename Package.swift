import PackageDescription

let package = Package(
  name: "Underwood",
  dependencies: [
    .Package(url: "https://github.com/nestproject/Nest.git", majorVersion: 0),
  ]
)
