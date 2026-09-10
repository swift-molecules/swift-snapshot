extension Snapshot {

    public struct Difference: Sendable, Hashable {
        public let summary: String
        public let lines: [Line]
        public let changes: [Change]

        public init(
            summary: String,
            lines: [Line] = [],
            changes: [Change] = []
        ) {
            self.summary = summary
            self.lines = lines
            self.changes = changes
        }
    }
}

extension Snapshot.Difference: CustomStringConvertible {
    public var description: String {
        guard !lines.isEmpty else { return summary }
        return summary + "\n" + lines.map(\.description).joined(separator: "\n")
    }
}
