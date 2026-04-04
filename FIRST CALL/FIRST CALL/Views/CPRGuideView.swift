import SwiftUI
import AudioToolbox
import CoreHaptics
import AVFoundation

private struct CPRData {
    static let topic: EmergencyTopic = {
        let steps: [EmergencyStep] = [
            EmergencyStep(
                number: 1,
                title: "Introduction",
                detail: "A step-by-step guide for performing life-saving CPR.",
                bullets: [
                    StepBullet(text: "If trained and confident with **rescue breaths**, use that method (go to Step 4)."),
                    StepBullet(text: "If not fully confident, use **hands-only CPR** (continue to Step 2).")
                ]
            ),
            EmergencyStep(
                number: 2,
                title: "Hands-Only CPR",
                detail: "Prepare to begin chest compressions.",
                bullets: [
                    StepBullet(text: "Kneel next to the person."),
                    StepBullet(text: "Place the **heel of one hand** on the center of the chest."),
                    StepBullet(text: "Put your **other hand on top** and interlock fingers."),
                    StepBullet(text: "Position **shoulders directly above** hands."),
                    StepBullet(text: "Press straight down **5–6 cm (2–2.5 in)** using body weight."),
                    StepBullet(text: "Release completely, letting the chest **recoil**.")
                ],
                illustrationName: "CPR step 2 hands only cpr",
                illustrationLabel: "Hands-only CPR"
            ),
            EmergencyStep(
                number: 3,
                title: "Chest Compressions",
                detail: "Follow the pulsing animation and beeping sound to maintain the correct compression rate.",
                subtitle: nil,
                bullets: nil
            ),
            EmergencyStep(
                number: 4,
                title: "CPR with Rescue Breaths",
                detail: "If trained and able, add rescue breaths.",
                bullets: [
                    StepBullet(text: "Perform **30 chest compressions** (as in hands-only CPR)."),
                    StepBullet(text: "Tilt the head back and lift the chin."),
                    StepBullet(text: "Pinch the nose and seal your mouth over theirs."),
                    StepBullet(text: "Give **2 rescue breaths**, each about **1 second**, watching for chest rise."),
                    StepBullet(text: "Continue cycles of 30 compressions and 2 breaths.")
                ],
                illustrationName: "CPR step 4  rescue breaths",
                illustrationLabel: "Rescue breaths"
            ),
            EmergencyStep(
                number: 5,
                title: "Chest Compressions",
                detail: "Follow the pulsing animation and beeping sound to maintain the correct compression rate. Remember to pause for rescue breaths after every 30 compressions.",
                bullets: nil
            )
        ]
        return EmergencyTopic(
            title: "CPR",
            category: .cardiac,
            symbol: "heart.fill",
            summary: "A step-by-step guide for performing life-saving CPR, including hands-only and rescue breath techniques.",
            symptoms: [],
            steps: steps
        )
    }()
}

struct CPRGuideView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let topic = CPRData.topic
    private enum Mode { case overview, guided }
    @State private var mode: Mode = .overview
    @State private var index: Int = 0
    @State private var playing: Bool = true
    @State private var showLocationSheet: Bool = false

    private var step: EmergencyStep { topic.steps[index] }
    private var isLast: Bool { index == topic.steps.count - 1 }
    private var isCompressionStep: Bool { step.title.localizedCaseInsensitiveContains("Chest Compressions") }

    var body: some View {
        Group {
            if mode == .overview {
                overview
            } else {
                guided
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private var overview: some View {
        VStack(spacing: 0) {
            // Top bar with close (white pill, red X)
            HStack {
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.cardiacRed)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.white))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            VStack(alignment: .leading, spacing: 10) {
                Text(topic.title)
                    .font(AppTypography.title())
                    .foregroundColor(.white)
                Text(topic.summary)
                    .font(AppTypography.body())
                    .foregroundColor(.white.opacity(0.92))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array(topic.steps.enumerated()), id: \.offset) { _, s in
                        StepCard(step: s, accent: AppColors.cardiacRed, collapsible: true, initiallyExpanded: false, activeIndex: nil, enableCPRButton: false, strongContent: true)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
            .background(Color.clear)
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()
                    FloatingPillButton(title: "Start Guide", accent: AppColors.cardiacRed) {
                        mode = .guided; index = 0; playing = true
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 14)
                .background(.ultraThinMaterial.opacity(0.0))
            }
        }
        .background(
            LinearGradient(colors: [AppColors.cardiacRed.opacity(0.92), AppColors.cardiacRed.opacity(0.82)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }

    private var guided: some View {
        VStack(spacing: 0) {
            GuideProgressHeader(title: topic.title, current: index + 1, total: topic.steps.count, accent: AppColors.cardiacRed, headerBackground: AppColors.cardiacRed, closeOnRight: true) {
                dismiss()
            }

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(topic.steps.enumerated()), id: \.offset) { i, s in
                            let isCompression = s.title.localizedCaseInsensitiveContains("Chest Compressions")
                            StepCard(
                                step: s,
                                accent: AppColors.cardiacRed,
                                collapsible: true,
                                initiallyExpanded: i == index,
                                activeIndex: index,
                                enableCPRButton: false,
                                extraContent: (i == index && isCompression) ? AnyView(CPRPulseView(accent: AppColors.cardiacRed, bpm: 110, playing: $playing)) : nil
                            )
                            .id("s_\(i)")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                }
                .onChange(of: index) { _, newValue in
                    withAnimation(.easeInOut(duration: 0.22)) {
                        proxy.scrollTo("s_\(newValue)", anchor: .top)
                    }
                }
            }
            .background(
                LinearGradient(colors: [AppColors.cardiacRed.opacity(0.95), AppColors.cardiacRed.opacity(0.85)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 16) {
                    circleButton(system: "arrow.left", label: "Previous", action: prev)
                        .opacity(index > 0 ? 1 : 0.4)
                        .disabled(index == 0)

                    FloatingPillButton(title: isLast ? "Call 112" : "Next Step", accent: AppColors.cardiacRed) {
                        primary()
                    }

                    circleButton(system: "location.fill", label: "Location") { showLocationSheet = true }
                        .sheet(isPresented: $showLocationSheet) {
                            LocationSheetView(contextTitle: topic.title, stepTitle: step.title)
                        }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.clear)
            }
        }
    }

    private func primary() {
        if isLast {
            if let url = URL(string: "tel://112") { openURL(url) }
        } else {
            next()
        }
    }

    private func next() {
        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        withAnimation(reduceMotion ? nil : .easeInOut(duration: 0.22)) {
            index = min(index + 1, topic.steps.count - 1)
        }
    }

    private func prev() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation(reduceMotion ? nil : .easeInOut(duration: 0.22)) {
            index = max(index - 1, 0)
        }
    }

    @ViewBuilder
    private func circleButton(system: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: system)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Circle().fill(AppColors.card))
                .overlay(Circle().stroke(Color.white.opacity(0.08), lineWidth: 1))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}

private struct CPRPulseView: View {
    let accent: Color
    let bpm: Double // target beats per minute
    @Binding var playing: Bool

    @State private var phase = false
    @State private var timer: Timer? = nil
    @State private var haptics: CHHapticEngine? = nil
    @State private var clicker: ClickPlayer? = nil

    private var interval: TimeInterval { 60.0 / max(bpm, 1) }

    var body: some View {
        ZStack {
            Circle()
                .fill(accent.opacity(0.25))
                .frame(width: 240, height: 240)
                .scaleEffect(phase ? 1.15 : 0.9)
                .animation(.easeOut(duration: interval * 0.9), value: phase)

            Circle()
                .fill(Color.white)
                .frame(width: 140, height: 140)
                .scaleEffect(phase ? 1.0 : 0.96)
                .animation(.easeOut(duration: interval * 0.5), value: phase)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .onAppear { prepareHaptics(); prepareAudio(); start() }
        .onDisappear { stop() }
        .onChange(of: playing) { _, newValue in
            if newValue { start() } else { stop() }
        }
    }

    private func start() {
        stop()
        guard playing else { return }
        // initial tick to sync visuals immediately
        tick()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            tick()
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    private func stop() {
        timer?.invalidate()
        timer = nil
        clicker?.stop()
    }

    private func tick() {
        phase.toggle()
        playPremiumHaptic()
        clicker?.playClick()
    }

    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            haptics = try CHHapticEngine()
            try haptics?.start()
        } catch {
            haptics = nil
        }
    }

    private func prepareAudio() {
        clicker = ClickPlayer()
        clicker?.startEngineIfNeeded()
    }

    private func playPremiumHaptic() {
        if let engine = haptics {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
            let sharp = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            let attack = CHHapticEventParameter(parameterID: .attackTime, value: 0.0)
            let release = CHHapticEventParameter(parameterID: .releaseTime, value: 0.05)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharp, attack, release], relativeTime: 0)
            do {
                let pattern = try CHHapticPattern(events: [event], parameters: [])
                let player = try engine.makePlayer(with: pattern)
                try player.start(atTime: 0)
            } catch {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            }
        } else {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
    }
}

#Preview("CPR Guide") {
    NavigationStack { CPRGuideView() }
        .preferredColorScheme(.dark)
}
