import Foundation

protocol Networkable {
    func fetch<T: Decodable>(from endpoint: String) async throws -> T
}

protocol CoinFetchable {
    func fetchCoins() async throws -> [Coin]
    func fetchCoinDetail(id: String) async throws -> CoinDetail
}
