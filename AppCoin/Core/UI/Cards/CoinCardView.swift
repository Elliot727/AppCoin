import SwiftUI

struct CoinCardView: View {
    let coin: Coin

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top){
                VStack(alignment: .leading, spacing: 4) {
                    Text(coin.name)
                        .font(.title3)
                        .bold()

                    Text(coin.symbol.uppercased())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("#\(coin.rank)")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .foregroundStyle(.blue)
                    .clipShape(Capsule())
            }

            Divider().opacity(0.3)

            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Current Price")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text("$" + format(coin.quotes.USD.price))
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    Text("24h Change")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    let change = coin.quotes.USD.percentChange24h
                    Text(String(format: "%.2f%%", change))
                        .fontWeight(.semibold)
                        .foregroundStyle(change >= 0 ? .green : .red)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("All-Time High")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack {
                    Text("$" + format(coin.quotes.USD.athPrice))
                        .font(.subheadline)

                    Text("(\(formatDate(coin.quotes.USD.athDate)))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        .contentShape(Rectangle())
    }

    private func format(_ value: Double) -> String {
        if value >= 1_000_000_000 {
            return String(format: "%.1fB", value / 1_000_000_000)
        } else if value >= 1_000_000 {
            return String(format: "%.1fM", value / 1_000_000)
        } else if value >= 1_000 {
            return String(format: "%.1fK", value / 1_000)
        } else {
            return String(format: "%.2f", value)
        }
    }

    private func formatDate(_ isoDateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .none

        if let date = isoFormatter.date(from: isoDateString) {
            return displayFormatter.string(from: date)
        } else {
            isoFormatter.formatOptions = [.withInternetDateTime]
            if let date = isoFormatter.date(from: isoDateString) {
                return displayFormatter.string(from: date)
            } else {
                return "Invalid date"
            }
        }
    }

}
