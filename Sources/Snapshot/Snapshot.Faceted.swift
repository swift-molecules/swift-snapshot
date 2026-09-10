extension Snapshot {

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
