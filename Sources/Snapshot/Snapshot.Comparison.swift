extension Snapshot {

    public struct Comparison<Value: Sendable>: Sendable {
        public let difference: @Sendable (Value, Value) -> Difference?

        public init(
            difference: @escaping @Sendable (Value, Value) -> Difference?
        ) {
            self.difference = difference
        }
    }
}

extension Snapshot.Comparison where Value: Equatable {

    public static func equality(summary: String = "Snapshot values differ") -> Self {
        Self { expected, actual in
            expected == actual ? nil : Snapshot.Difference(summary: summary)
        }
    }
}
