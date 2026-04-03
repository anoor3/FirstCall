import SwiftUI

struct EmergencyDetailView: View {
    let topic: EmergencyTopic
    @Environment(\.openURL) private var openURL
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var showActions = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerCard
                SymptomSection(symptoms: topic.symptoms, accent: topic.accent)
                stepsSection
                startGuideButton
                EmergencyActionBar(accent: topic.accent, callNumber: "911")
            }
            .padding(20)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle(topic.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: topic.symbol)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(topic.accent)
                    .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: 6) {
                    Text(topic.title)
                        .font(AppTypography.title())
                        .foregroundColor(AppColors.strongText)

                    HStack(spacing: 8) {
                        Circle().fill(topic.accent).frame(width: 8, height: 8)
                        Text(topic.category.displayName)
                            .font(AppTypography.footnote())
                            .foregroundColor(AppColors.subtleText)
                            .padding(.vertical, 4)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Category: \(topic.category.displayName)")
                }
                Spacer(minLength: 0)
            }

            Text(topic.summary)
                .font(AppTypography.body())
                .foregroundColor(AppColors.subtleText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.surfaceCard)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(AppColors.separator, lineWidth: 1)
                )
        )
    }

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("What to do")
                .font(AppTypography.header())
                .foregroundColor(AppColors.strongText)
                .padding(.horizontal, 4)
            VStack(spacing: 12) {
                ForEach(topic.steps) { step in
                    StepCard(step: step, accent: topic.accent)
                }
            }
        }
    }

    private var startGuideButton: some View {
        NavigationLink {
            GuidedModeView(topic: topic)
        } label: {
            PrimaryActionButton(title: "Start Guide", subtitle: "One step at a time", accent: topic.accent, systemImage: "play.fill")
        }
        .accessibilityLabel("Start guided steps")
        .buttonStyle(.plain)
    }
}

#Preview("Detail") {
    NavigationStack { EmergencyDetailView(topic: EmergencySampleData.heartAttack) }
        .preferredColorScheme(.dark)
}

