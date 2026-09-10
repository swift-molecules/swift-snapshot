extension Snapshot.Representation where Value == [UInt8] {

    public static var bytes: Self {
        Self(encode: { $0 }, decode: { $0 })
    }
}
