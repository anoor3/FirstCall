import SwiftUI
import CoreLocation
import AVFoundation
import UIKit

struct LocationSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @StateObject private var provider = LocationProvider()
    var contextTitle: String? = nil
    var stepTitle: String? = nil
    @State private var speaking: Bool = false
    private let tts = AVSpeechSynthesizer()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Group {
                    if let loc = provider.location {
                        VStack(spacing: 8) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(AppColors.poisonGreen)
                            if let text = formattedPlacemark() {
                                Text(text)
                                    .font(AppTypography.body())
                                    .foregroundColor(AppColors.strongText)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            Text(String(format: "Lat %.4f, Lon %.4f (±%.0fm)", loc.coordinate.latitude, loc.coordinate.longitude, loc.horizontalAccuracy))
                                .font(AppTypography.footnote())
                                .foregroundColor(AppColors.subtleText)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(AppColors.card)
                        )
                        .padding(.horizontal, 20)
                    } else if let msg = provider.errorMessage {
                        Text(msg)
                            .font(AppTypography.body())
                            .foregroundColor(AppColors.subtleText)
                            .padding()
                    } else {
                        ProgressView().tint(AppColors.poisonGreen)
                    }
                }

                HStack(spacing: 12) {
                    if let loc = provider.location {
                        Button {
                            let url = URL(string: "http://maps.apple.com/?ll=\(loc.coordinate.latitude),\(loc.coordinate.longitude)")!
                            openURL(url)
                        } label: {
                            PrimaryActionButton(title: "Open in Maps", accent: AppColors.poisonGreen, systemImage: "map.fill")
                        }.buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)

                // Suggested call prompt for panicked users
                VStack(alignment: .leading, spacing: 8) {
                    Text("Suggested Call Prompt")
                        .font(AppTypography.bodyStrong())
                        .foregroundColor(AppColors.strongText)
                    Text(promptText())
                        .font(AppTypography.body())
                        .foregroundColor(AppColors.subtleText)
                        .fixedSize(horizontal: false, vertical: true)

                    HStack(spacing: 12) {
                        Button(action: speakPrompt) {
                            actionChip(label: speaking ? "Stop" : "Speak", system: speaking ? "stop.fill" : "speaker.wave.2.fill", bg: AppColors.card)
                        }
                        Button(action: copyPrompt) {
                            actionChip(label: "Copy", system: "doc.on.doc.fill", bg: AppColors.card)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(AppColors.card)
                )
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 24)
            .background(AppColors.background.ignoresSafeArea())
            .navigationTitle("Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") { dismiss() }
                        .foregroundColor(AppColors.strongText)
                }
            }
        }.onAppear { provider.start() }
        .preferredColorScheme(.dark)
    }

    private func formattedPlacemark() -> String? {
        guard let pm = provider.placemark else { return nil }
        let parts = [pm.name, pm.locality, pm.administrativeArea, pm.country].compactMap { $0 }
        guard !parts.isEmpty else { return nil }
        return parts.joined(separator: ", ")
    }

    private func promptText() -> String {
        let whereText: String
        if let pm = formattedPlacemark() {
            whereText = pm
        } else if let loc = provider.location {
            whereText = String(format: "coordinates %.4f by %.4f", loc.coordinate.latitude, loc.coordinate.longitude)
        } else {
            whereText = "my current location"
        }
        let topic = contextTitle ?? "an emergency"
        let step = stepTitle.map { ", currently on \($0)" } ?? ""
        return "I need help. I'm at \(whereText). It's \(topic)\(step). Please send assistance now."
    }

    private func speakPrompt() {
        if speaking {
            tts.stopSpeaking(at: .immediate)
            speaking = false
            return
        }
        let utterance = AVSpeechUtterance(string: promptText())
        utterance.voice = AVSpeechSynthesisVoice(language: Locale.current.identifier)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        tts.speak(utterance)
        speaking = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }

    private func copyPrompt() {
        UIPasteboard.general.string = promptText()
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }

    private func actionChip(label: String, system: String, bg: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: system)
                .foregroundColor(.white)
            Text(label)
                .foregroundColor(.white)
                .font(AppTypography.footnote())
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            Capsule().fill(bg)
        )
    }
}

#Preview {
    LocationSheetView()
        .preferredColorScheme(.dark)
}
