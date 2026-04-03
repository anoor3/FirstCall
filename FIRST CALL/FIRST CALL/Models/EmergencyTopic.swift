import SwiftUI

struct EmergencyTopic: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let category: EmergencyCategory
    let symbol: String
    let summary: String
    let symptoms: [String]
    let steps: [EmergencyStep]

    var accent: Color { category.accent }
}

