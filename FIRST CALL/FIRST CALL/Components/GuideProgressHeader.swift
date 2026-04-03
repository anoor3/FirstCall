import SwiftUI

struct GuideProgressHeader: View {
    let title: String
    let current: Int
    let total: Int
    let accent: Color
    var onClose: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.strongText)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(AppColors.card)
                        )
                }
                .accessibilityLabel("Exit guide")

                Spacer()
                Text("Step \(current) of \(total)")
                    .font(AppTypography.footnote())
                    .foregroundColor(AppColors.subtleText)
                Spacer()
                Image(systemName: "shield.fill")
                    .foregroundStyle(accent)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(AppColors.card)
                    )
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .font(AppTypography.title2())
                    .foregroundColor(AppColors.strongText)
                Spacer()
            }
            .padding(.horizontal, 20)

            ProgressView(value: Double(current), total: Double(total))
                .tint(accent)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
        }
        .background(AppColors.background)
    }
}

#Preview("Header") {
    GuideProgressHeader(title: "Choking", current: 1, total: 4, accent: AppColors.breathingBlue) {}
        .preferredColorScheme(.dark)
}

