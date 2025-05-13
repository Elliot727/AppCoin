import SwiftUI

struct LinkListView: View {
    let links: CoinDetail.Links

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let website = links.website?.first {
                LinkRow(label: "Website", url: website)
            }
            if let explorer = links.explorer?.first {
                LinkRow(label: "Explorer", url: explorer)
            }
            if let reddit = links.reddit?.first {
                LinkRow(label: "Reddit", url: reddit)
            }
            if let facebook = links.facebook?.first {
                LinkRow(label: "Facebook", url: facebook)
            }
            if let youtube = links.youtube?.first {
                LinkRow(label: "YouTube", url: youtube)
            }
            if let source = links.sourceCode?.first {
                LinkRow(label: "Source Code", url: source)
            }
        }
    }
}
