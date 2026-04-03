import Foundation

struct EmergencyStep: Identifiable, Hashable {
    var id = UUID()
    let number: Int
    let title: String
    let detail: String
    let tip: String?
    let warning: String?
}

