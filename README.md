# Snapshot

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-primitives/swift-snapshot/actions/workflows/ci.yml/badge.svg)](https://github.com/swift-primitives/swift-snapshot/actions/workflows/ci.yml)

Test-independent snapshot capture and comparison for Swift.

`Snapshot` owns values and operations that remain meaningful without a test runner: byte representations, comparisons, structured differences, normalization, redaction, capture strategies, and faceted capture. Recording policy, reference storage, inline source rewriting, and test failure mapping belong to relation packages outside this repository.

## Use

```swift
import Snapshot

let strategy = Snapshot.Strategy<String, String>.lines
    .normalizing(.init { $0.replacing("\r\n", with: "\n") })
    .redacting(.init { $0.replacing("secret", with: "[redacted]") })

let actual = await strategy.capture("hello\nsecret")
let difference = strategy.comparison.difference("hello\nexpected", actual)
```

Add the package and its single product:

```swift
.package(
    url: "https://github.com/swift-primitives/swift-snapshot.git",
    branch: "main"
)

.product(name: "Snapshot", package: "swift-snapshot")
```

## Boundaries

- `Snapshot.Representation<Value>` reversibly encodes a value as bytes.
- `Snapshot.Comparison<Value>` produces an optional structured difference.
- `Snapshot.Strategy<Input, Output>` captures an input and supplies its representation and comparison.
- `Snapshot.Normalization` canonicalizes equivalent output.
- `Snapshot.Redaction` deterministically removes volatile or sensitive output.
- `Snapshot.Faceted` captures one input through a primary strategy and named facets.

The package has no dependency on Test, Apple Testing, Foundation, FileSystem, JSON, SwiftSyntax, Clock, Memory, Console, or HTML. Its textual comparison composes the canonical Sequence Difference operation.

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
