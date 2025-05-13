import SwiftUI

struct LinkRow: View {
    let label: String
    let url: String

    var body: some View {
        if let url = URL(string: url) {
            HStack {
                Image(systemName: "link")
                    .foregroundStyle(.blue)

                Link(label, destination: url)
                    .foregroundStyle(.blue)
                    .lineLimit(1)

                Spacer()
            }
        }
    }
}
