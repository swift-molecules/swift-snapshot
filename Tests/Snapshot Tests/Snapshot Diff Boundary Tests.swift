import Snapshot
import Testing

@Suite
struct `Snapshot line diff boundaries` {
    private func sides(_ expected: String, _ actual: String) -> (expected: [String], actual: [String])? {
        guard let lines = Snapshot.Comparison<String>.lines.difference(expected, actual)?.lines else { return nil }
        var left: [String] = []
        var right: [String] = []
        for line in lines {
            switch line {
            case .context(let value): left.append(value); right.append(value)
            case .removed(let value): left.append(value)
            case .added(let value): right.append(value)
            }
        }
        return (left, right)
    }

    @Test(arguments: [
        ("", "a"), ("a", ""), ("a\nb\nc", "c\nb\na"), ("a\na\na", "a\na"), ("x\ny", "x\ny\n"),
        ("1\n2\n3\n4\n5", "0\n1\n3\n5\n6"), ("same\nline", "same\nLINE"), ("\n\n", "\n"),
    ])
    func `context and removals rebuild the expected text, context and additions the actual`(_ pair: (String, String)) throws {
        let rebuilt = try #require(sides(pair.0, pair.1))
        #expect(rebuilt.expected.joined(separator: "\n") == pair.0)
        #expect(rebuilt.actual.joined(separator: "\n") == pair.1)
    }

    @Test
    func `identical texts have no difference`() {
        #expect(Snapshot.Comparison<String>.lines.difference("a\nb", "a\nb") == nil)
        #expect(Snapshot.Comparison<String>.lines.difference("", "") == nil)
    }

    @Test
    func `the summary counts removals and additions`() {
        let difference = Snapshot.Comparison<String>.lines.difference("a\nb\nc", "a\nx")
        #expect(difference?.summary == "2 removed, 1 added")
    }
}
