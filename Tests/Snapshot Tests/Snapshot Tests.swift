// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-snapshot open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-snapshot project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Snapshot
import Testing

@Suite
struct `Snapshot Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Snapshot Tests`.Unit {
    @Test
    func `representations round trip text and bytes`() {
        let text = Snapshot.Representation<String>.text
        let bytes = Snapshot.Representation<[UInt8]>.bytes

        #expect(text.decode(text.encode("héllo")) == "héllo")
        #expect(bytes.decode(bytes.encode([0, 1, 255])) == [0, 1, 255])
    }

    @Test
    func `equal values have no difference`() {
        let comparison = Snapshot.Comparison<String>.equality()

        #expect(comparison.difference("same", "same") == nil)
        #expect(comparison.difference("old", "new")?.summary == "Snapshot values differ")
    }

    @Test
    func `line comparison retains ordered changes`() {
        let difference = Snapshot.Comparison<String>.lines.difference(
            "first\nold\nlast",
            "first\nnew\nlast"
        )

        #expect(difference?.lines == [
            .context("first"),
            .removed("old"),
            .added("new"),
            .context("last"),
        ])
        #expect(difference?.description.contains("-old") == true)
        #expect(difference?.description.contains("+new") == true)
    }

    @Test
    func `normalizations and redactions compose in order`() {
        let trim = Snapshot.Normalization<String> { $0.replacing(" ", with: "") }
        let lowercase = Snapshot.Normalization<String> { $0.lowercased() }
        let secrets = Snapshot.Redaction<String> { $0.replacing("token", with: "[secret]") }
        let names = Snapshot.Redaction<String> { $0.replacing("alice", with: "[name]") }

        #expect(trim.followed(by: lowercase).apply("  VALUE  ") == "value")
        #expect(secrets.followed(by: names).apply("alice token") == "[name] [secret]")
    }
}

extension `Snapshot Tests`.`Edge Case` {
    @Test
    func `empty text and terminal newline remain distinguishable`() {
        let difference = Snapshot.Comparison<String>.lines.difference("", "\n")

        #expect(difference != nil)
        #expect(difference?.lines.contains(.added("")) == true)
    }

    @Test
    func `structural changes retain path components`() {
        let change = Snapshot.Difference.Change.modified(
            path: ["users", "0", "name"],
            old: "Alice",
            new: "Bob"
        )
        let difference = Snapshot.Difference(summary: "Name changed", changes: [change])

        #expect(difference.changes == [change])
    }
}

extension `Snapshot Tests`.Integration {
    @Test
    func `strategy composition captures normalized redacted output`() async {
        let strategy = Snapshot.Strategy<String, String>.lines
            .pullback { (value: Int) in " value: \(value) " }
            .normalizing(.init { $0.replacing(" ", with: "") })
            .redacting(.init { $0.replacing("42", with: "[number]") })

        #expect(await strategy.capture(42) == "value:[number]")
        #expect(strategy.suffix == "txt")
    }

    @Test
    func `faceted capture evaluates primary and named strategies`() async {
        let lines = Snapshot.Strategy<String, String>.lines
        let faceted = Snapshot.Faceted(
            primary: lines,
            facets: [
                Snapshot.Facet(name: "lowercase", strategy: lines.pullback { $0.lowercased() })
            ]
        )

        let result = await faceted.capture("VALUE")

        #expect(result.primary == "VALUE")
        #expect(result.facets.map(\.name) == ["lowercase"])
        #expect(result.facets.map(\.value) == ["value"])
    }
}
