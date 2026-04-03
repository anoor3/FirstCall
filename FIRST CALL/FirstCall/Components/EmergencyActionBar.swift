import SwiftUI

struct EmergencyActionBar: View {
    var accent: Color
    var callNumber: String = "911"
    @Environment(\.openURL) private var openURL
    @State private var showLocationSheet = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Emergency Actions")
                .font(AppTypography.header())
                .foregroundColor(AppColors.strongText)
                .padding(.horizontal, 4)
            HStack(spacing: 12) {
                Button(action: call)
                {
                    actionButton(label: "Call \(callNumber)", system: "phone.fill", bg: accent)
                }
                .accessibilityLabel("Call emergency \(callNumber)")

                Button(action: { showLocationSheet = true }) {
                    actionButton(label: "Share Location", system: "location.fill", bg: AppColors.cardElevated)
                }
                .accessibilityLabel("Share location")
                .sheet(isPresented: $showLocationSheet) {
                    LocationSheetView()
                }
            }
        }
    }

    private func actionButton(label: String, system: String, bg: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: system)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .accessibilityHidden(true)
            Text(label)
                .font(AppTypography.bodyStrong())
                .foregroundColor(.white)
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(bg)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }

    private func call() {
        // Use tel:// scheme. On simulator, this won't place a call.
        // TODO: Consider using a call confirmation view for clarity.
        if let url = URL(string: "tel://\(callNumber)") {
            openURL(url)
        }
    }
}

private struct LocationSheetView: View {
    // Placeholder UI to enable future CoreLocation integration.
    // For now, shows mock coordinates and a simple share option.
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(AppColors.card)
                    .frame(height: 160)
                    .overlay(
                        VStack(spacing: 8) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(AppColors.poisonGreen)
                            Text("Mock Location")
                                .font(AppTypography.bodyStrong())
                                .foregroundColor(AppColors.strongText)
                            Text("123 Main St, Springfield")
                                .font(AppTypography.body())
                                .foregroundColor(AppColors.subtleText)
                            Text("Lat 37.7749, Lon -122.4194")
                                .font(AppTypography.footnote())
                                .foregroundColor(AppColors.subtleText)
                        }
                    )
                    .padding(.horizontal, 20)

                Button(action: { dismiss() }) {
                    PrimaryActionButton(title: "Done", accent: AppColors.poisonGreen, systemImage: "checkmark")
                }
                .buttonStyle(.plain)
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
        }
        .preferredColorScheme(.dark)
    }
}

#Preview("Actions") {
    EmergencyActionBar(accent: AppColors.cardiacRed)
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}

