extension Snapshot {

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
