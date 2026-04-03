import SwiftUI

enum EmergencyCategory: String, CaseIterable, Identifiable {
    case breathingAirway = "Breathing & Airway"
    case cardiac = "Cardiac"
    case bleedingInjury = "Bleeding / Injury"
    case burns = "Burns"
    case poisoning = "Poisoning"
    case neurologic = "Neurologic"

    var id: String { rawValue }

    var displayName: String { rawValue }

    var symbol: String {
        switch self {
        case .breathingAirway: return "lungs.fill"
        case .cardiac: return "heart.fill"
        case .bleedingInjury: return "bandage.fill"
        case .burns: return "flame.fill"
        case .poisoning: return "leaf.fill"
        case .neurologic: return "brain.head.profile"
        }
    }

    var accent: Color { AppColors.accent(for: self) }
}

