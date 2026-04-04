import SwiftUI

struct CategorySection: View {
    let category: EmergencyCategory
    let topics: [EmergencyTopic]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Circle().fill(category.accent).frame(width: 7, height: 7)
                Text(category.displayName)
                    .font(AppTypography.bodyStrong())
                    .foregroundColor(AppColors.strongText)
            }
            .padding(.horizontal, 2)

            VStack(spacing: 8) {
                ForEach(topics) { topic in
                    NavigationLink(value: topic) {
                        EmergencyRow(topic: topic)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationDestination(for: EmergencyTopic.self) { topic in
            EmergencyDetailView(topic: topic)
        }
    }
}

#Preview("Section") {
    NavigationStack { CategorySection(category: .cardiac, topics: [EmergencySampleData.heartAttack, EmergencySampleData.cardiacArrest]) }
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
