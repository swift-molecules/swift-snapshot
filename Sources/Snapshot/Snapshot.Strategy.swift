// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-snapshot open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-snapshot project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension Snapshot {
    /// Captures an input as a serializable, comparable representation.
    public struct Strategy<Input: Sendable, Output: Sendable>: Sendable {
        public let suffix: String?
        public let representation: Representation<Output>
        public let comparison: Comparison<Output>
        public let capture: @Sendable (Input) async -> Output

        public init(
            suffix: String?,
            representation: Representation<Output>,
            comparison: Comparison<Output>,
            capture: @escaping @Sendable (Input) -> Output
        ) {
            self.suffix = suffix
            self.representation = representation
            self.comparison = comparison
            self.capture = { capture($0) }
        }

        public init(
            suffix: String?,
            representation: Representation<Output>,
            comparison: Comparison<Output>,
            capture: @escaping @Sendable (Input) async -> Output
        ) {
            self.suffix = suffix
            self.representation = representation
            self.comparison = comparison
            self.capture = capture
        }
    }
}

extension Snapshot.Strategy {
    public func pullback<NewInput: Sendable>(
        _ transform: @escaping @Sendable (NewInput) -> Input
    ) -> Snapshot.Strategy<NewInput, Output> {
        Snapshot.Strategy<NewInput, Output>(
            suffix: suffix,
            representation: representation,
            comparison: comparison,
            capture: { newInput in await capture(transform(newInput)) }
        )
    }

    public func normalizing(_ normalization: Snapshot.Normalization<Output>) -> Self {
        Self(
            suffix: suffix,
            representation: representation,
            comparison: comparison,
            capture: { input in normalization.apply(await capture(input)) }
        )
    }

    public func redacting(_ redaction: Snapshot.Redaction<Output>) -> Self {
        Self(
            suffix: suffix,
            representation: representation,
            comparison: comparison,
            capture: { input in redaction.apply(await capture(input)) }
        )
    }
}

extension Snapshot.Strategy where Input == Output {
    public init(
        suffix: String?,
        representation: Snapshot.Representation<Output>,
        comparison: Snapshot.Comparison<Output>
    ) {
        self.init(
            suffix: suffix,
            representation: representation,
            comparison: comparison,
            capture: { $0 }
        )
    }
}
