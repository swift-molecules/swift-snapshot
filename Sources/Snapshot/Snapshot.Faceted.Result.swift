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

extension Snapshot.Faceted {
    /// Values captured by a faceted strategy, without test pass/fail policy.
    public struct Result: Sendable {
        public let primary: Output
        public let facets: [Snapshot.Facet<Never, Output>.Output]

        public init(
            primary: Output,
            facets: [Snapshot.Facet<Never, Output>.Output]
        ) {
            self.primary = primary
            self.facets = facets
        }
    }
}
