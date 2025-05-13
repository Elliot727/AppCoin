import SwiftUI
struct CoinDetailView: View {
    let detail: CoinDetail

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(detail.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(detail.symbol.uppercased())
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                if let startedAt = detail.startedAt {
                    SectionView(title: "Launched", content: formatDate(startedAt))
                }

                if let description = detail.description, !description.isEmpty {
                    SectionView(title: "About", content: description)
                }

                if let links = detail.links {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Links")
                            .font(.headline)

                        LinkListView(links: links)
                    }
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationTitle(detail.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formatDate(_ isoDateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium

        if let date = isoFormatter.date(from: isoDateString) {
            return displayFormatter.string(from: date)
        } else {
            return "Unknown"
        }
    }
}






