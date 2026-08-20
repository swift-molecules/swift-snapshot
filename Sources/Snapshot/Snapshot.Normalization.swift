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
    /// Canonicalizes semantically equivalent snapshot values.
    public struct Normalization<Value: Sendable>: Sendable {
        public let apply: @Sendable (Value) -> Value

        public init(apply: @escaping @Sendable (Value) -> Value) {
            self.apply = apply
        }
    }
}

extension Snapshot.Normalization {
    public func followed(by next: Self) -> Self {
        Self { next.apply(apply($0)) }
    }
}
