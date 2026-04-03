import SwiftUI

enum AppTypography {
    static func largeTitle() -> Font { .system(.largeTitle, design: .rounded).weight(.semibold) }
    static func title() -> Font { .system(.title, design: .rounded).weight(.semibold) }
    static func title2() -> Font { .system(.title2, design: .rounded).weight(.semibold) }
    static func header() -> Font { .system(.title3, design: .rounded).weight(.semibold) }
    static func bodyStrong() -> Font { .system(.body, design: .rounded).weight(.semibold) }
    static func body() -> Font { .system(.body, design: .rounded) }
    static func footnote() -> Font { .system(.footnote, design: .rounded) }
    static func caption() -> Font { .system(.caption, design: .rounded) }
}

