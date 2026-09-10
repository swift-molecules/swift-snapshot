extension Snapshot.Difference {

    public enum Line: Sendable, Hashable {
        case context(String)
        case removed(String)
        case added(String)
    }
}

extension Snapshot.Difference.Line: CustomStringConvertible {
    public var description: String {
        switch self {
        case .context(let value): " " + value
        case .removed(let value): "-" + value
        case .added(let value): "+" + value
        }
    }
}
