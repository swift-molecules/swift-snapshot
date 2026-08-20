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

extension Snapshot.Representation where Value == [UInt8] {
    /// Identity representation for byte snapshots.
    public static var bytes: Self {
        Self(encode: { $0 }, decode: { $0 })
    }
}
