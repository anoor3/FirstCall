import SwiftUI

enum AppColors {
    // Surfaces
    static let background = Color(red: 0.06, green: 0.06, blue: 0.07) // near-black
    static let card = Color(red: 0.12, green: 0.12, blue: 0.13)
    static let cardElevated = Color(red: 0.16, green: 0.16, blue: 0.18)
    static let separator = Color.white.opacity(0.08)
    static let subtleText = Color.white.opacity(0.7)
    static let strongText = Color.white

    // Category accents
    static let breathingBlue = Color(red: 0.26, green: 0.56, blue: 0.98)
    static let cardiacRed = Color(red: 0.88, green: 0.16, blue: 0.22)
    static let bleedingRuby = Color(red: 0.78, green: 0.08, blue: 0.20)
    static let burnsOrange = Color(red: 1.00, green: 0.52, blue: 0.16)
    static let poisonGreen = Color(red: 0.24, green: 0.78, blue: 0.42)
    static let neuroPurple = Color(red: 0.66, green: 0.40, blue: 0.92)

    static func accent(for category: EmergencyCategory) -> Color {
        switch category {
        case .breathingAirway: return breathingBlue
        case .cardiac: return cardiacRed
        case .bleedingInjury: return bleedingRuby
        case .burns: return burnsOrange
        case .poisoning: return poisonGreen
        case .neurologic: return neuroPurple
        }
    }
}

extension ShapeStyle where Self == Color {
    static var surfaceBackground: Color { AppColors.background }
    static var surfaceCard: Color { AppColors.card }
    static var surfaceElevated: Color { AppColors.cardElevated }
    static var surfaceSeparator: Color { AppColors.separator }
}

