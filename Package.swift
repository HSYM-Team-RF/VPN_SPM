// swift-tools-version:5.9
//
//  LibXrayBinary — SPM-обёртка над pre-built LibXray.xcframework.
//
//  В этом репозитории:
//   • Package.swift          — манифест пакета
//   • README.md              — описание
//
//  В GitHub Releases (для каждой версии):
//   • LibXray.xcframework.zip — собственно фреймворк
//
//  SHA256 в `binaryTarget(checksum:)` ниже должен СТРОГО совпадать
//  с хешем .zip, прикреплённого к Release с матчащимся tag'ом.
//

import PackageDescription

let package = Package(
    name: "LibXrayBinary",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "LibXray",
            targets: ["LibXray"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "LibXray",
            // Для обновления версии — поменяй tag'и в URL (`1.0.0` → `1.0.1`)
            // и checksum пересчитай: `swift package compute-checksum LibXray.xcframework.zip`.
            url: "https://github.com/TST-TEAM-APPS/LibXrayBinary/raw/1.0.0/LibXray.xcframework.zip",
            checksum: "9af1078dbc66d3be7e5b3bce8d3a4b3e59f02611a6773aa6ba63e7275ed8b525"
        )
    ]
)
