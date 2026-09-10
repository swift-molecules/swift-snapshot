extension Snapshot.Faceted {

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
