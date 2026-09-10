extension Snapshot {

    public struct Redaction<Value: Sendable>: Sendable {
        public let apply: @Sendable (Value) -> Value

        public init(apply: @escaping @Sendable (Value) -> Value) {
            self.apply = apply
        }
    }
}

extension Snapshot.Redaction {
    public func followed(by next: Self) -> Self {
        Self { next.apply(apply($0)) }
    }
}
