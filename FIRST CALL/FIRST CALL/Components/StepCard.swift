import SwiftUI

struct StepCard: View {
    let step: EmergencyStep
    let accent: Color
    var collapsible: Bool = false
    var initiallyExpanded: Bool = false
    var activeIndex: Int? = nil // used to control expansion from parent when guiding
    var enableCPRButton: Bool = true
    var extraContent: AnyView? = nil
    var strongContent: Bool = false
    @State private var expanded: Bool = false
    
    @Environment(\.openURL) private var openURL

    init(step: EmergencyStep, accent: Color, collapsible: Bool = false, initiallyExpanded: Bool = false, activeIndex: Int? = nil, enableCPRButton: Bool = true, extraContent: AnyView? = nil, strongContent: Bool = false) {
        self.step = step
        self.accent = accent
        self.collapsible = collapsible
        self.initiallyExpanded = initiallyExpanded
        self.activeIndex = activeIndex
        self.enableCPRButton = enableCPRButton
        self.extraContent = extraContent
        self.strongContent = strongContent
        _expanded = State(initialValue: initiallyExpanded || !collapsible)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(expanded ? accent.opacity(0.35) : accent.opacity(0.18))
                    Text("Step \(step.number)")
                        .font(AppTypography.footnote())
                        .foregroundColor(expanded ? .white : accent)
                        .padding(.horizontal, 8)
                }
                .frame(width: 72, height: 28)
                .accessibilityLabel("Step \(step.number)")

                VStack(alignment: .leading, spacing: 2) {
                    Text(step.title)
                        .font(AppTypography.header())
                        .foregroundColor(expanded ? .white : AppColors.strongText)
                        .lineLimit(2)
                        .minimumScaleFactor(0.9)
                    if !expanded, let subtitle = step.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(AppTypography.footnote())
                            .foregroundColor(AppColors.subtleText)
                            .lineLimit(2)
                    }
                }

                Spacer(minLength: 0)

                if collapsible {
                    Image(systemName: expanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(AppColors.subtleText)
                        .accessibilityHidden(true)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture { if collapsible { withAnimation(.easeInOut(duration: 0.2)) { expanded.toggle() } } }

            if expanded {
                VStack(alignment: .leading, spacing: 10) {
                    if let subtitle = step.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(AppTypography.body())
                            .foregroundColor(.white.opacity(0.85))
                    }
                    if let bullets = step.bullets, !bullets.isEmpty {
                        let isNumbered = (step.listStyle == .numbered)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(Array(bullets.enumerated()), id: \.offset) { idx, b in
                                HStack(alignment: .firstTextBaseline, spacing: 10) {
                                    Group {
                                        if isNumbered { Text("\(idx+1).").font(AppTypography.bodyStrong()) }
                                        else { Image(systemName: "circle.fill").font(.system(size: 6)) }
                                    }
                                    .foregroundColor(.white)
                                    Text(attributed(b.text))
                                        .font(strongContent ? AppTypography.bodyStrong() : AppTypography.body())
                                        .foregroundColor(.white)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    } else {
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            Image(systemName: "circle.fill").font(.system(size: 6)).foregroundColor(.white)
                            Text(step.detail)
                                .font(strongContent ? AppTypography.bodyStrong() : AppTypography.body())
                                .foregroundColor(.white.opacity(0.9))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    if let extra = extraContent {
                        extra
                    }

                    if let name = step.illustrationName, let alt = step.illustrationLabel {
                        StepIllustrationView(name: name, alt: alt, accent: accent)
                            .padding(.top, 8)
                    }

                    if enableCPRButton && shouldShowCPRButton(step: step) {
                        Button {
                            showCPRGuide = true
                        } label: {
                            PrimaryActionButton(title: "Perform CPR", accent: AppColors.cardiacRed)
                        }
                        .buttonStyle(.plain)
                        .fullScreenCover(isPresented: $showCPRGuide) {
                            CPRGuideView()
                        }
                        .padding(.top, 6)
                    }

                    if let warning = step.warning {
                        infoRow(text: warning, system: "exclamationmark.triangle.fill")
                    }
                    if let tip = step.tip {
                        infoRow(text: tip, system: "lightbulb.fill")
                    }
                    if let call = step.callNumber {
                        Button {
                            if let url = URL(string: "tel://\(call)") { openURL(url) }
                        } label: {
                            PrimaryActionButton(title: "Call \(call)", accent: AppColors.cardiacRed, systemImage: "phone.fill")
                        }
                        .buttonStyle(.plain)
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    expanded
                    ? AnyShapeStyle(LinearGradient(colors: [accent.opacity(0.55), accent.opacity(0.35)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    : AnyShapeStyle(Color.surfaceCard)
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(expanded ? Color.white.opacity(0.08) : AppColors.separator, lineWidth: 1)
        )
        .onChange(of: activeIndex) { _, newValue in
            guard collapsible else { return }
            withAnimation(.easeInOut(duration: 0.22)) {
                if let newValue = newValue {
                    expanded = (newValue + 1) == step.number
                } else {
                    expanded = false
                }
            }
        }
    }

    private func infoRow(text: String, system: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: system)
                .foregroundStyle(.white)
                .font(.system(size: 14, weight: .semibold))
                .accessibilityHidden(true)
            Text(text)
                .font(AppTypography.footnote())
                .foregroundColor(.white)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.black.opacity(0.25))
        )
    }

    private func attributed(_ markdown: String) -> AttributedString {
        (try? AttributedString(markdown: markdown)) ?? AttributedString(markdown)
    }

    @State private var showCPRGuide: Bool = false

    private func shouldShowCPRButton(step: EmergencyStep) -> Bool {
        let hay = (step.title + " " + step.detail).lowercased()
        return hay.contains("cpr")
    }
}

#Preview("Step") {
    StepCard(step: EmergencySampleData.choking.steps.first!, accent: AppColors.bleedingRuby)
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
