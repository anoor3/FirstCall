import SwiftUI

struct GuideProgressHeader: View {
    let title: String
    let current: Int
    let total: Int
    let accent: Color
    var headerBackground: Color = AppColors.background
    var closeOnRight: Bool = false
    var onClose: () -> Void

    var body: some View {
        Group {
            if closeOnRight {
                // CPR-style: full-red header, centered title, compact step label, bold white progress, close on right
                VStack(spacing: 8) {
                    HStack {
                        Spacer()
                        Button(action: onClose) {
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(AppColors.cardiacRed)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.white))
                        }
                        .accessibilityLabel("Exit guide")
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                    Text(title)
                        .font(AppTypography.title2())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)

                    Text("Step \(current) of \(total)")
                        .font(AppTypography.footnote())
                        .foregroundColor(.white.opacity(0.9))
                        .frame(maxWidth: .infinity)

                    ProgressView(value: Double(current), total: Double(total))
                        .tint(.white)
                        .scaleEffect(x: 1.0, y: 1.8, anchor: .center)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }
                .background(headerBackground)
            } else {
                // Default header used elsewhere in the app
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
                .background(headerBackground)
            }
        }
    }
}

#Preview("Header-Default") {
    GuideProgressHeader(title: "Choking", current: 1, total: 4, accent: AppColors.breathingBlue) {}
        .preferredColorScheme(.dark)
}

#Preview("Header-CPR") {
    GuideProgressHeader(title: "CPR", current: 2, total: 5, accent: AppColors.cardiacRed, headerBackground: AppColors.cardiacRed, closeOnRight: true) {}
        .preferredColorScheme(.dark)
}
