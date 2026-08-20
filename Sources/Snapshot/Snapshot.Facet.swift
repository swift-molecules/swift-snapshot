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
    /// A named strategy within a faceted snapshot.
    public struct Facet<Input: Sendable, Value: Sendable>: Sendable {
        public let name: String
        public let strategy: Strategy<Input, Value>

        public init(name: String, strategy: Strategy<Input, Value>) {
            self.name = name
            self.strategy = strategy
        }
    }
}
