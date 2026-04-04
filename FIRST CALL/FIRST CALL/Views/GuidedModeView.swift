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
                    StepCard(step: step, accent: topic.accent, collapsible: false, initiallyExpanded: true)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .transition(.opacity.combined(with: .move(edge: .trailing)))
            }
            .background(AppColors.background.ignoresSafeArea())
            .safeAreaInset(edge: .bottom) {
                Button(action: next) {
                    PrimaryActionButton(
                        title: isLast ? "Finish Guide" : "Next Step",
                        subtitle: isLast ? nil : "Step \(index + 2) of \(topic.steps.count)",
                        accent: topic.accent,
                        systemImage: isLast ? "checkmark" : "arrow.right"
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 14)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isLast ? "Finish guide" : "Next step")
                .background(.ultraThinMaterial.opacity(0.0))
            }
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

    // tipBox handled inside StepCard; retained only if needed later.
}

#Preview("Guide") {
    NavigationStack { GuidedModeView(topic: EmergencySampleData.choking) }
        .preferredColorScheme(.dark)
}
