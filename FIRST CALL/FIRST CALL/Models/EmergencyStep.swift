import Foundation

struct StepBullet: Identifiable, Hashable {
    let id = UUID()
    let text: String // supports basic Markdown for emphasis
}

enum StepListStyle: String, Hashable {
    case bullets
    case numbered
}

struct EmergencyStep: Identifiable, Hashable {
    var id = UUID()
    let number: Int
    let title: String
    let detail: String
    let tip: String?
    let warning: String?
    let callNumber: String?
    let subtitle: String?
    let bullets: [StepBullet]?
    let listStyle: StepListStyle?
    let illustrationName: String?
    let illustrationLabel: String?

    init(
        number: Int,
        title: String,
        detail: String,
        tip: String? = nil,
        warning: String? = nil,
        callNumber: String? = nil,
        subtitle: String? = nil,
        bullets: [StepBullet]? = nil,
        listStyle: StepListStyle? = nil,
        illustrationName: String? = nil,
        illustrationLabel: String? = nil
    ) {
        self.number = number
        self.title = title
        self.detail = detail
        self.tip = tip
        self.warning = warning
        self.callNumber = callNumber
        self.subtitle = subtitle
        self.bullets = bullets
        self.listStyle = listStyle
        self.illustrationName = illustrationName
        self.illustrationLabel = illustrationLabel
    }
}
