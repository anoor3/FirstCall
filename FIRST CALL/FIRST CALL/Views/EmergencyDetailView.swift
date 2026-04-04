import SwiftUI

struct EmergencyDetailView: View {
    let topic: EmergencyTopic
    @Environment(\.openURL) private var openURL
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var showActions = true

    @State private var activeStepIndex: Int? = nil
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerCard
                    SymptomSection(symptoms: topic.symptoms, accent: topic.accent)
                    stepsSection
                        .id("steps")
                    EmergencyActionBar(accent: topic.accent, callNumber: "911")
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 80) // allow space for sticky button
            }
            .onChange(of: activeStepIndex) { _, newValue in
                if let idx = newValue {
                    // delay to allow expansion animation to start
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            proxy.scrollTo("step_\(idx)", anchor: .top)
                        }
                    }
                }
            }
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle(topic.title)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 16) {
                if activeStepIndex != nil {
                    circleButton(system: "arrow.left", label: "Previous", action: prevStep)
                        .opacity((activeStepIndex ?? 0) > 0 ? 1 : 0.4)
                        .disabled((activeStepIndex ?? 0) == 0)
                } else { Spacer(minLength: 0) }

                FloatingPillButton(
                    title: centerButtonTitle(),
                    accent: AppColors.cardiacRed,
                    action: startOrNextOrCall
                )

                if activeStepIndex != nil {
                    circleButton(system: "location.fill", label: "Location") { showLocationSheet = true }
                        .sheet(isPresented: $showLocationSheet) {
                            LocationSheetView(contextTitle: topic.title, stepTitle: activeStepIndex.flatMap { idx in idx < topic.steps.count ? topic.steps[idx].title : nil })
                        }
                } else { Spacer(minLength: 0) }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.clear)
        }
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
                .fill(
                    LinearGradient(colors: [topic.accent.opacity(0.18), AppColors.card], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
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
                ForEach(Array(topic.steps.enumerated()), id: \.element.id) { index, step in
                    StepCard(step: step, accent: topic.accent, collapsible: true, initiallyExpanded: false, activeIndex: activeStepIndex)
                        .id("step_\(index)")
                }
            }
        }
    }

    @State private var showLocationSheet = false

    private func startOrNext() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        if let idx = activeStepIndex {
            if idx >= topic.steps.count - 1 {
                // finish
                withAnimation(.easeInOut(duration: 0.2)) { activeStepIndex = nil }
            } else {
                withAnimation(.easeInOut(duration: 0.22)) { activeStepIndex = idx + 1 }
            }
        } else {
            withAnimation(.easeInOut(duration: 0.22)) { activeStepIndex = 0 }
        }
    }

    private func prevStep() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        guard let idx = activeStepIndex, idx > 0 else { return }
        withAnimation(.easeInOut(duration: 0.22)) { activeStepIndex = idx - 1 }
    }

    private func centerButtonTitle() -> String {
        guard let idx = activeStepIndex else { return "Start Guide" }
        let isLast = idx == topic.steps.count - 1
        if isLast {
            return "Call \(currentCallNumber())"
        } else {
            return "Next Step"
        }
    }

    private func startOrNextOrCall() {
        guard let idx = activeStepIndex else { startOrNext(); return }
        let isLast = idx == topic.steps.count - 1
        if isLast {
            if let url = URL(string: "tel://\(currentCallNumber())") { openURL(url) }
        } else {
            startOrNext()
        }
    }

    private func currentCallNumber() -> String {
        if let idx = activeStepIndex, idx < topic.steps.count {
            return topic.steps[idx].callNumber ?? "911"
        }
        return "911"
    }

    @ViewBuilder
    private func circleButton(system: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: system)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    Circle().fill(AppColors.card)
                )
                .overlay(
                    Circle().stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}

#Preview("Detail") {
    NavigationStack { EmergencyDetailView(topic: EmergencySampleData.heartAttack) }
        .preferredColorScheme(.dark)
}
