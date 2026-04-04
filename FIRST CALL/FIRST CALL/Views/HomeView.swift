import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                content
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search emergencies"))
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(AppColors.background, for: .navigationBar)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("FirstCall")
                .font(AppTypography.header())
                .foregroundColor(AppColors.subtleText)
                .accessibilityHidden(true)
            Text("Act fast. Stay calm.")
                .font(AppTypography.footnote())
                .foregroundColor(AppColors.subtleText)
        }
        .padding(.top, 6)
    }

    private var content: some View {
        Group {
            if filteredResults.isEmpty {
                emptyState
            } else if isSearching {
                resultsList
            } else {
                categorySections
            }
        }
        .animation(.easeInOut(duration: 0.2), value: filteredResults)
    }

    private var categorySections: some View {
        VStack(spacing: 20) {
            ForEach(EmergencyCategory.allCases) { category in
                if let items = EmergencySampleData.grouped[category]?.sorted(by: { $0.title < $1.title }) {
                    CategorySection(category: category, topics: items)
                }
            }
        }
    }

    private var resultsList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Results")
                .font(AppTypography.header())
                .foregroundColor(AppColors.strongText)
                .padding(.horizontal, 2)

            VStack(spacing: 10) {
                ForEach(filteredResults) { topic in
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

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(AppColors.subtleText)
            Text("No matches found")
                .font(AppTypography.header())
                .foregroundColor(AppColors.strongText)
            Text("Try searching for another emergency topic.")
                .font(AppTypography.body())
                .foregroundColor(AppColors.subtleText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.surfaceCard)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("No results. Try another search.")
    }

    private var isSearching: Bool { !searchText.trimmingCharacters(in: .whitespaces).isEmpty }
    private var filteredResults: [EmergencyTopic] {
        let query = searchText.lowercased().trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return EmergencySampleData.topics }
        return EmergencySampleData.topics.filter { $0.title.lowercased().contains(query) }
    }
}

#Preview("Home") {
    NavigationStack { HomeView() }
        .preferredColorScheme(.dark)
}
