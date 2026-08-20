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
    /// A format-neutral structural change.
    public enum Change: Sendable, Hashable {
        case added(path: [String], value: String)
        case removed(path: [String], value: String)
        case modified(path: [String], old: String, new: String)
    }
}
