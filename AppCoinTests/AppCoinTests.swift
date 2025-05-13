import Foundation
import Testing
@testable import AppCoin

struct AppCoinTests {

    struct MockNetwork: Networkable {
        var mockCoins: [Coin] = []
        var mockCoinDetail: CoinDetail?
        var shouldFail: Bool = false

        func fetch<T: Decodable>(from endpoint: String) async throws -> T {
            if shouldFail {
                throw URLError(.badServerResponse)
            }

            if endpoint.contains("/coins/") {
                guard let detail = mockCoinDetail as? T else {
                    throw URLError(.cannotParseResponse)
                }
                return detail
            } else {
                guard let coins = mockCoins as? T else {
                    throw URLError(.cannotParseResponse)
                }
                return coins
            }
        }
    }

    struct CoinService: CoinFetchable {
        let network: Networkable

        func fetchCoins() async throws -> [Coin] {
            try await network.fetch(from: "/coins")
        }

        func fetchCoinDetail(id: String) async throws -> CoinDetail {
            try await network.fetch(from: "/coins/\(id)")
        }
    }

    @Test func testFetchCoinsSuccess() async throws {
        let mockCoins = [
            Coin(id: "bitcoin", name: "Bitcoin", symbol: "BTC", rank: 1, totalSupply: 21000000, maxSupply: 21000000, betaValue: 1.2, firstDataAt: "2013-04-28", lastUpdated: "2025-05-13", quotes: QuoteWrapper(USD: USDQuote(
                price: 60000, volume24h: 1000000000, volume24hChange24h: 1.5,
                marketCap: 1200000000, marketCapChange24h: 2.1,
                percentChange15m: 0.1, percentChange30m: 0.2, percentChange1h: 0.3,
                percentChange6h: 0.4, percentChange12h: 0.5, percentChange24h: 0.6,
                percentChange7d: 1.0, percentChange30d: 2.0, percentChange1y: 50.0,
                athPrice: 69000, athDate: "2021-11-10", percentFromPriceAth: -13.0
            )))
        ]
        let network = MockNetwork(mockCoins: mockCoins)
        let service = CoinService(network: network)

        let coins = try await service.fetchCoins()

        #expect(coins.count == 1)
        #expect(coins.first?.name == "Bitcoin")
    }

    @Test func testFetchCoinDetailSuccess() async throws {
        let mockDetail = CoinDetail(id: "bitcoin", name: "Bitcoin", symbol: "BTC", description: "The first cryptocurrency.", startedAt: "2009-01-03", links: nil)
        let network = MockNetwork(mockCoinDetail: mockDetail)
        let service = CoinService(network: network)

        let detail = try await service.fetchCoinDetail(id: "bitcoin")

        #expect(detail.name == "Bitcoin")
        #expect(detail.description == "The first cryptocurrency.")
    }

    @Test func testFetchCoinsFailure() async throws {
        let network = MockNetwork(shouldFail: true)
        let service = CoinService(network: network)

        do {
            _ = try await service.fetchCoins()
            #expect(Bool(false), "Expected error but got success")
        } catch {
            #expect(error is URLError)
        }
    }

    @Test func testFetchCoinDetailFailure() async throws {
        let network = MockNetwork(shouldFail: true)
        let service = CoinService(network: network)

        do {
            _ = try await service.fetchCoinDetail(id: "bitcoin")
            #expect(Bool(false), "Expected error but got success")
        } catch {
            #expect(error is URLError)
        }
    }
}
