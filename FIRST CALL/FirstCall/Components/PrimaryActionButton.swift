import SwiftUI

struct PrimaryActionButton: View {
    let title: String
    var subtitle: String? = nil
    let accent: Color
    var systemImage: String = ""

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            if !systemImage.isEmpty {
                Image(systemName: systemImage)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .accessibilityHidden(true)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppTypography.bodyStrong())
                    .foregroundColor(.white)
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(AppTypography.footnote())
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            Spacer()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(colors: [accent, accent.opacity(0.85)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    PrimaryActionButton(title: "Start Guide", subtitle: "One step at a time", accent: AppColors.cardiacRed, systemImage: "play.fill")
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}

