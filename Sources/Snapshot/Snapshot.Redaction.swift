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
    /// Replaces volatile or sensitive snapshot content deterministically.
    public struct Redaction<Value: Sendable>: Sendable {
        public let apply: @Sendable (Value) -> Value

        public init(apply: @escaping @Sendable (Value) -> Value) {
            self.apply = apply
        }
    }
}

extension Snapshot.Redaction {
    public func followed(by next: Self) -> Self {
        Self { next.apply(apply($0)) }
    }
}
