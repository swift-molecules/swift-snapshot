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
    /// Captures one input through a primary strategy and named facets.
    public struct Faceted<Input: Sendable, Output: Sendable>: Sendable {
        public let primary: Strategy<Input, Output>
        public let facets: [Facet<Input, Output>]

        public init(
            primary: Strategy<Input, Output>,
            facets: [Facet<Input, Output>]
        ) {
            self.primary = primary
            self.facets = facets
        }
    }
}

extension Snapshot.Faceted {
    public func capture(_ input: Input) async -> Result {
        var outputs: [Snapshot.Facet<Never, Output>.Output] = []
        for facet in facets {
            outputs.append(
                Snapshot.Facet<Never, Output>.Output(
                    name: facet.name,
                    value: await facet.strategy.capture(input)
                )
            )
        }
        return Result(primary: await primary.capture(input), facets: outputs)
    }
}
