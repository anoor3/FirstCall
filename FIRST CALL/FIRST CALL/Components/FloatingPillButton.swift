import SwiftUI

struct FloatingPillButton: View {
    var title: String
    var accent: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTypography.bodyStrong())
                .foregroundColor(.white)
                .padding(.horizontal, 22)
                .padding(.vertical, 12)
                .background(
                    Capsule(style: .circular)
                        .fill(accent)
                )
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }
}

#Preview {
    ZStack {
        AppColors.background
        FloatingPillButton(title: "Next Step", accent: AppColors.cardiacRed) {}
    }
    .preferredColorScheme(.dark)
}

