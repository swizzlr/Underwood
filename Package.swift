import PackageDescription

let package = Package(
  name: "Underwood",
  targets: [
      Target(
        name: "UnderwoodTests",
        dependencies: [.Target(name: "Underwood")]),
      Target(name: "Underwood")
    ],
  dependencies: [
    .Package(url: "https://github.com/nestproject/Nest.git", majorVersion: 0),
  ]
)
