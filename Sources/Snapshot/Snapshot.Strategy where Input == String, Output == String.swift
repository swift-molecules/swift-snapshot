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

extension Snapshot.Strategy where Input == String, Output == String {
    public static var text: Self {
        Self(
            suffix: "txt",
            representation: .text,
            comparison: .equality(summary: "Text content differs")
        )
    }

    public static var lines: Self {
        Self(
            suffix: "txt",
            representation: .text,
            comparison: .lines
        )
    }
}
