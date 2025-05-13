import Foundation

final class CoinService: CoinFetchable {
    private let networkService: Networkable
    
    init(networkService: Networkable = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCoins() async throws -> [Coin] {
        return try await networkService.fetch(from: "/tickers")
    }
    
    func fetchCoinDetail(id: String) async throws -> CoinDetail {
        return try await networkService.fetch(from: "/coins/\(id)")
    }

}
