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

extension Snapshot.Strategy where Input == [UInt8], Output == [UInt8] {
    public static var bytes: Self {
        Self(
            suffix: "bin",
            representation: .bytes,
            comparison: .equality(summary: "Binary content differs")
        )
    }
}
