import Foundation

struct CoinDetail: Codable {
    let id: String
    let name: String
    let symbol: String
    let description: String?
    let startedAt: String?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, description
        case startedAt = "started_at"
        case links
    }

    struct Links: Codable {
        let explorer: [String]?
        let facebook: [String]?
        let reddit: [String]?
        let sourceCode: [String]?
        let website: [String]?
        let youtube: [String]?
        
        enum CodingKeys: String, CodingKey {
            case explorer, facebook, reddit, website, youtube
            case sourceCode = "source_code"
        }
    }
}
