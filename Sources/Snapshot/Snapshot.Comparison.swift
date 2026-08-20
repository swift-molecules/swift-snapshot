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
    /// Comparison policy for two snapshot representations.
    public struct Comparison<Value: Sendable>: Sendable {
        public let difference: @Sendable (Value, Value) -> Difference?

        public init(
            difference: @escaping @Sendable (Value, Value) -> Difference?
        ) {
            self.difference = difference
        }
    }
}

extension Snapshot.Comparison where Value: Equatable {
    /// Equality comparison with a caller-supplied mismatch summary.
    public static func equality(summary: String = "Snapshot values differ") -> Self {
        Self { expected, actual in
            expected == actual ? nil : Snapshot.Difference(summary: summary)
        }
    }
}
