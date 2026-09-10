extension Snapshot.Strategy where Input == [UInt8], Output == [UInt8] {
    public static var bytes: Self {
        Self(
            suffix: "bin",
            representation: .bytes,
            comparison: .equality(summary: "Binary content differs")
        )
    }
}
