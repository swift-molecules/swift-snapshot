extension Snapshot.Representation where Value == String {

    public static var text: Self {
        Self(
            encode: { Array($0.utf8) },
            decode: { String(decoding: $0, as: UTF8.self) }
        )
    }
}
