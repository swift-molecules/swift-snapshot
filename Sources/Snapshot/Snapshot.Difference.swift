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
    /// A structured explanation of why two representations differ.
    public struct Difference: Sendable, Hashable {
        public let summary: String
        public let lines: [Line]
        public let changes: [Change]

        public init(
            summary: String,
            lines: [Line] = [],
            changes: [Change] = []
        ) {
            self.summary = summary
            self.lines = lines
            self.changes = changes
        }
    }
}

extension Snapshot.Difference: CustomStringConvertible {
    public var description: String {
        guard !lines.isEmpty else { return summary }
        return summary + "\n" + lines.map(\.description).joined(separator: "\n")
    }
}
