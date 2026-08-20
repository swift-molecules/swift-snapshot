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

extension Snapshot.Representation where Value == String {
    /// UTF-8 representation for text snapshots.
    public static var text: Self {
        Self(
            encode: { Array($0.utf8) },
            decode: { String(decoding: $0, as: UTF8.self) }
        )
    }
}
