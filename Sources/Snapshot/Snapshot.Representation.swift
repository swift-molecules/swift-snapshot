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
    /// A reversible byte representation for a snapshot value.
    public struct Representation<Value: Sendable>: Sendable {
        public let encode: @Sendable (Value) -> [UInt8]
        public let decode: @Sendable ([UInt8]) -> Value?

        public init(
            encode: @escaping @Sendable (Value) -> [UInt8],
            decode: @escaping @Sendable ([UInt8]) -> Value?
        ) {
            self.encode = encode
            self.decode = decode
        }
    }
}
