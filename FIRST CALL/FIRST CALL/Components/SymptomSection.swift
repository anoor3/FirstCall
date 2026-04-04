import SwiftUI

struct SymptomSection: View {
    let symptoms: [String]
    var accent: Color
    @State private var expanded: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            DisclosureGroup(isExpanded: $expanded) {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(symptoms, id: \.self) { s in
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            Image(systemName: "smallcircle.filled.circle")
                                .font(.system(size: 8))
                                .foregroundStyle(accent)
                                .accessibilityHidden(true)
                            Text(s)
                                .font(AppTypography.body())
                                .foregroundColor(AppColors.subtleText)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .padding(.top, 6)
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "list.bullet")
                        .foregroundStyle(accent)
                        .accessibilityHidden(true)
                    Text("Symptoms")
                        .font(AppTypography.header())
                        .foregroundColor(AppColors.strongText)
                }
            }
            .tint(accent)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.surfaceCard)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(AppColors.separator, lineWidth: 1)
            )
        }
    }
}

#Preview("Symptoms") {
    SymptomSection(symptoms: EmergencySampleData.choking.symptoms, accent: AppColors.breathingBlue)
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
