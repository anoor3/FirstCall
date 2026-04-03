import SwiftUI

struct GuidedModeView: View {
    let topic: EmergencyTopic
    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var index: Int = 0
    @State private var animateStep: Bool = false

    private var step: EmergencyStep { topic.steps[index] }
    private var isLast: Bool { index == topic.steps.count - 1 }

    var body: some View {
        VStack(spacing: 0) {
            GuideProgressHeader(title: topic.title, current: index + 1, total: topic.steps.count, accent: topic.accent) {
                dismiss()
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(step.title)
                        .font(AppTypography.title())
                        .foregroundColor(AppColors.strongText)
                        .padding(.top, 8)

                    Text(step.detail)
                        .font(AppTypography.body())
                        .foregroundColor(AppColors.subtleText)

                    if let warning = step.warning {
                        tipBox(text: warning, systemImage: "exclamationmark.octagon.fill", tint: topic.accent)
                    }
                    if let tip = step.tip {
                        tipBox(text: tip, systemImage: "lightbulb.fill", tint: topic.accent.opacity(0.9))
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.surfaceCard)
                        .padding(.horizontal, 20)
                )
                .padding(.vertical, 20)
                .transition(.opacity.combined(with: .move(edge: .trailing)))
            }
            .background(AppColors.background.ignoresSafeArea())

            VStack(spacing: 12) {
                Button(action: next) {
                    PrimaryActionButton(
                        title: isLast ? "Finish Guide" : "Next Step",
                        subtitle: isLast ? nil : "Step \(index + 2) of \(topic.steps.count)",
                        accent: topic.accent,
                        systemImage: isLast ? "checkmark" : "arrow.right"
                    )
                }
                .accessibilityLabel(isLast ? "Finish guide" : "Next step")
                .buttonStyle(.plain)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .background(AppColors.background.ignoresSafeArea())
        }
        .navigationBarBackButtonHidden(true)
        .onAppear { animateStep = true }
    }

    private func next() {
        let h = UIImpactFeedbackGenerator(style: .rigid)
        h.impactOccurred()
        if isLast {
            let n = UINotificationFeedbackGenerator()
            n.notificationOccurred(.success)
            dismiss()
        } else {
            withAnimation(reduceMotion ? nil : .easeInOut) {
                index += 1
            }
        }
    }

    private func tipBox(text: String, systemImage: String, tint: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(tint)
                .font(.system(size: 18, weight: .semibold))
                .accessibilityHidden(true)
            Text(text)
                .font(AppTypography.body())
                .foregroundColor(AppColors.subtleText)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AppColors.cardElevated)
        )
    }
}

#Preview("Guide") {
    NavigationStack { GuidedModeView(topic: EmergencySampleData.choking) }
        .preferredColorScheme(.dark)
}

