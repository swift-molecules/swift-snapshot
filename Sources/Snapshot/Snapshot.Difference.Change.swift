extension Snapshot.Difference {

    public enum Change: Sendable, Hashable {
        case added(path: [String], value: String)
        case removed(path: [String], value: String)
        case modified(path: [String], old: String, new: String)
    }
}
