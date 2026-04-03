import SwiftUI

struct StepCard: View {
    let step: EmergencyStep
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                ZStack {
                    Circle().fill(accent.opacity(0.18))
                    Text("\(step.number)")
                        .font(AppTypography.bodyStrong())
                        .foregroundColor(accent)
                }
                .frame(width: 34, height: 34)
                .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 4) {
                    Text(step.title)
                        .font(AppTypography.bodyStrong())
                        .foregroundColor(AppColors.strongText)
                    Text(step.detail)
                        .font(AppTypography.body())
                        .foregroundColor(AppColors.subtleText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            if let warning = step.warning {
                infoRow(text: warning, system: "exclamationmark.triangle.fill")
            }
            if let tip = step.tip {
                infoRow(text: tip, system: "lightbulb.fill")
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.surfaceCard)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(AppColors.separator, lineWidth: 1)
        )
    }

    private func infoRow(text: String, system: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: system)
                .foregroundStyle(accent)
                .font(.system(size: 14, weight: .semibold))
                .accessibilityHidden(true)
            Text(text)
                .font(AppTypography.footnote())
                .foregroundColor(AppColors.subtleText)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AppColors.cardElevated)
        )
    }
}

#Preview("Step") {
    StepCard(step: EmergencySampleData.choking.steps.first!, accent: AppColors.bleedingRuby)
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}

