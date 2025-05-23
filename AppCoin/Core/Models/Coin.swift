import SwiftUI

struct Coin: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let totalSupply: Double
    let maxSupply: Double
    let betaValue: Double
    let firstDataAt: String
    let lastUpdated: String
    let quotes: QuoteWrapper

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, rank
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case betaValue = "beta_value"
        case firstDataAt = "first_data_at"
        case lastUpdated = "last_updated"
        case quotes
    }
}

struct QuoteWrapper: Codable, Hashable {
    let USD: USDQuote
}

struct USDQuote: Codable, Hashable {
    let price: Double
    let volume24h: Double
    let volume24hChange24h: Double
    let marketCap: Double
    let marketCapChange24h: Double
    let percentChange15m: Double
    let percentChange30m: Double
    let percentChange1h: Double
    let percentChange6h: Double
    let percentChange12h: Double
    let percentChange24h: Double
    let percentChange7d: Double
    let percentChange30d: Double
    let percentChange1y: Double
    let athPrice: Double
    let athDate: String
    let percentFromPriceAth: Double

    enum CodingKeys: String, CodingKey {
        case price
        case volume24h = "volume_24h"
        case volume24hChange24h = "volume_24h_change_24h"
        case marketCap = "market_cap"
        case marketCapChange24h = "market_cap_change_24h"
        case percentChange15m = "percent_change_15m"
        case percentChange30m = "percent_change_30m"
        case percentChange1h = "percent_change_1h"
        case percentChange6h = "percent_change_6h"
        case percentChange12h = "percent_change_12h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d = "percent_change_7d"
        case percentChange30d = "percent_change_30d"
        case percentChange1y = "percent_change_1y"
        case athPrice = "ath_price"
        case athDate = "ath_date"
        case percentFromPriceAth = "percent_from_price_ath"
    }
}
