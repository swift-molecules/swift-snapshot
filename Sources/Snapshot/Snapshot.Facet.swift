extension Snapshot {

    public struct Facet<Input: Sendable, Value: Sendable>: Sendable {
        public let name: String
        public let strategy: Strategy<Input, Value>

        public init(name: String, strategy: Strategy<Input, Value>) {
            self.name = name
            self.strategy = strategy
        }
    }
}
