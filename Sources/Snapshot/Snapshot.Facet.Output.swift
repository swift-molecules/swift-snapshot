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

extension Snapshot.Facet {
    /// A named captured facet value.
    public struct Output: Sendable {
        public let name: String
        public let value: Value

        public init(name: String, value: Value) {
            self.name = name
            self.value = value
        }
    }
}
