import Foundation

@Observable
final class CoinViewModel {
    private let coinService: CoinFetchable

    var coins: [Coin] = []
    var selectedCoinDetail: CoinDetail?
    var isLoading: Bool = false
    var errorMessage: String?

    init(coinService: CoinFetchable = CoinService()) {
        self.coinService = coinService
    }

    @MainActor
    func loadCoins() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedCoins = try await coinService.fetchCoins()
            coins = fetchedCoins
        } catch {
            errorMessage = "Failed to load coins: \(error.localizedDescription)"
        }

        isLoading = false
    }

    @MainActor
    func loadCoinDetail(id: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let detail = try await coinService.fetchCoinDetail(id: id)
            selectedCoinDetail = detail
        } catch {
            errorMessage = "Failed to load coin detail: \(error.localizedDescription)"
        }

        isLoading = false
    }

}
