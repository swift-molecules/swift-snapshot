import Sequence_Difference_Primitives

extension Snapshot.Comparison where Value == String {

    public static var lines: Self {
        Self { expected, actual in
            guard expected != actual else { return nil }

            let expectedLines = expected.split(
                separator: "\n",
                omittingEmptySubsequences: false
            ).map(String.init)
            let actualLines = actual.split(
                separator: "\n",
                omittingEmptySubsequences: false
            ).map(String.init)
            let changes = Sequence.Difference.diff(expectedLines, actualLines)
            let counts = changes.counts()
            var lines: [Snapshot.Difference.Line] = []
            var iterator = changes.makeIterator()

            while let change = iterator.next() {
                switch change {
                case .first(let value): lines.append(.removed(value))
                case .second(let value): lines.append(.added(value))
                case .both(let value): lines.append(.context(value))
                }
            }

            return Snapshot.Difference(
                summary: "\(counts.removed) removed, \(counts.inserted) added",
                lines: lines
            )
        }
    }
}
