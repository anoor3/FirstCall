import SwiftUI

struct EmergencyRow: View {
    let topic: EmergencyTopic

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(topic.accent.opacity(0.18))
                Image(systemName: topic.symbol)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(topic.accent)
            }
            .frame(width: 36, height: 36)
            .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 1) {
                Text(topic.title)
                    .font(AppTypography.bodyStrong())
                    .foregroundColor(AppColors.strongText)
                Text(topic.summary)
                    .font(AppTypography.footnote())
                    .foregroundColor(AppColors.subtleText)
                    .lineLimit(1)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(AppColors.subtleText)
                .accessibilityHidden(true)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.surfaceCard)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(AppColors.separator, lineWidth: 1)
        )
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(topic.title). \(topic.category.displayName)")
    }
}

#Preview("Row") {
    EmergencyRow(topic: EmergencySampleData.severeBleeding)
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
