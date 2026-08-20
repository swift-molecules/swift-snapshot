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

extension Snapshot.Difference {
    /// One test-independent line in a textual difference.
    public enum Line: Sendable, Hashable {
        case context(String)
        case removed(String)
        case added(String)
    }
}

extension Snapshot.Difference.Line: CustomStringConvertible {
    public var description: String {
        switch self {
        case .context(let value): " " + value
        case .removed(let value): "-" + value
        case .added(let value): "+" + value
        }
    }
}
