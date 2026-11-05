# swift-snapshot

Use this package when you need to describe how a value becomes a snapshot and how two snapshots are compared, without committing to a test runner or to storage. Start from `Snapshot.Strategy<Input, Output>`, which bundles a capture, a `Snapshot.Representation<Value>` for bytes on disk and a `Snapshot.Comparison<Value>` that produces a `Snapshot.Difference`; use `Snapshot.Faceted<Input, Output>` to capture several named views of one input. The package never reads or writes reference files and never decides pass or fail: `Snapshot.Strategy.suffix` is only a hint for whoever stores the bytes. For recording, reference handling and pass/fail results inside a test run, use `Test.Snapshot.Strategy` from the sibling swift-test.

## Laws

- A `Snapshot.Comparison.difference` returns `nil` exactly when the two values are equal, for both `Snapshot.Comparison.equality(summary:)` and `Snapshot.Comparison.lines`. The first argument is the expected value, the second the actual one.
- `Snapshot.Comparison.equality(summary:)` reports only its summary, with no lines and no changes. `Snapshot.Strategy.text` uses the summary "Text content differs" and `Snapshot.Strategy.bytes` uses "Binary content differs".
- `Snapshot.Comparison.lines` splits on `"\n"` and keeps empty lines, so `""` and `"\n"` differ. It splits on the `Character` `"\n"`, and a CR LF pair is a different single `Character`, so text with CR LF line endings is compared as one line. The context and removed lines, in order, rebuild the expected text; the context and added lines, in order, rebuild the actual text. The summary is "N removed, M added".
- No built-in comparison fills `Snapshot.Difference.changes`; structural changes with paths come only from a custom `Snapshot.Comparison`. The `description` of a `Snapshot.Difference` is its summary alone when it has no lines, otherwise the summary followed by one line each, prefixed with a space for context, `-` for removed and `+` for added. Changes are not rendered.
- `Snapshot.Representation.text` and `Snapshot.Representation.bytes` round-trip: decoding an encoded value gives the value back. `Snapshot.Representation.text` decodes invalid UTF-8 by repairing it, never by returning `nil`.
- `a.followed(by: b)` on `Snapshot.Normalization` and `Snapshot.Redaction` applies `a` first, then `b`.
- `pullback` transforms the input before capture. `normalizing` and `redacting` transform the captured output, in the order the calls are chained. All three keep the strategy's suffix, representation and comparison.
- `Snapshot.Faceted.capture` runs every capture again on each call; nothing is cached. Facets are captured one at a time in declared order, then the primary strategy, and `Snapshot.Faceted.Result.facets` keeps the declared order and names.
