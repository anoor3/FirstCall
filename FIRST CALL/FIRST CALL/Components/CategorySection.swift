import SwiftUI

struct CategorySection: View {
    let category: EmergencyCategory
    let topics: [EmergencyTopic]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Circle().fill(category.accent).frame(width: 8, height: 8)
                Text(category.displayName)
                    .font(AppTypography.header())
                    .foregroundColor(AppColors.strongText)
            }
            .padding(.horizontal, 2)

            VStack(spacing: 10) {
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

