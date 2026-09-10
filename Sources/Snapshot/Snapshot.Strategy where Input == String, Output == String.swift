extension Snapshot.Strategy where Input == String, Output == String {
    public static var text: Self {
        Self(
            suffix: "txt",
            representation: .text,
            comparison: .equality(summary: "Text content differs")
        )
    }

    public static var lines: Self {
        Self(
            suffix: "txt",
            representation: .text,
            comparison: .lines
        )
    }
}
