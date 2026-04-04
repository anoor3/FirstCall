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
                .sheet(isPresented: $showLocationSheet) { LocationSheetView() }
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

#Preview("Actions") {
    EmergencyActionBar(accent: AppColors.cardiacRed)
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
