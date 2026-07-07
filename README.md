# LibXrayBinary

Pre-built `LibXray.xcframework` distributed via Swift Package Manager.

Содержит только iOS slices (device `arm64` + simulator `arm64_x86_64`).
macOS и MacCatalyst slices вырезаны. Debug symbols (DWARF) — стрипнуты.

## Sizes

| | |
|---|---|
| Unzipped xcframework on disk | 114 MB |
| Zipped (что в Release) | 36 MB |

## Usage in your Xcode project

1. File → Add Package Dependencies…
2. URL: `https://github.com/<USER>/LibXrayBinary`
3. Dependency Rule: `Up to Next Major Version — 1.0.0`
4. Add Package
5. Add `LibXray` to your target's "Frameworks, Libraries, and Embedded Content" (Embed & Sign)

## Releasing a new version

```bash
# 1. Replace the LibXray.xcframework folder locally with new build
# 2. Strip debug from each slice (requires llvm-objcopy from brew install llvm):
for slice in LibXray.xcframework/ios-arm64 LibXray.xcframework/ios-arm64_x86_64-simulator; do
  /opt/homebrew/opt/llvm/bin/llvm-objcopy --strip-debug \
    "$slice/LibXray.framework/LibXray" "$slice/LibXray.framework/LibXray.tmp"
  mv "$slice/LibXray.framework/LibXray.tmp" "$slice/LibXray.framework/LibXray"
done

# 3. Zip
zip -r -X LibXray.xcframework.zip LibXray.xcframework

# 4. Compute new checksum
swift package compute-checksum LibXray.xcframework.zip

# 5. Update `url:` and `checksum:` in Package.swift
# 6. Commit, tag, push, create Release with zip attached
git tag 1.0.1
git push origin main --tags
gh release create 1.0.1 LibXray.xcframework.zip --title "1.0.1"
```

## Notes

- iOS minimum: 17.0 (set in `platforms` in Package.swift)
- Architecture support: arm64 (device), arm64 + x86_64 (simulator)
- The library is built from upstream `github.com/xtls/libxray` (Go-based, gomobile)
