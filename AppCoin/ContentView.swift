import SwiftUI

struct ContentView: View {
    @State var viewModel = CoinViewModel()
    @State private var isNavigatingToDetail = false
    @State private var searchText = ""

    var filteredCoins: [Coin] {
        if searchText.isEmpty {
            return viewModel.coins
        } else {
            return viewModel.coins.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.symbol.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()

                if viewModel.isLoading {
                    ProgressView("Loading coins...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text(error)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task { await viewModel.loadCoins() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredCoins, id: \.id) { coin in
                                Button {
                                    Task {
                                        await viewModel.loadCoinDetail(id: coin.id)
                                        isNavigatingToDetail = true
                                    }
                                } label: {
                                    CoinCardView(coin: coin)
                                        .padding(.horizontal)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top)
                    }
                    .navigationTitle("💰 Coins")
                    .searchable(text: $searchText, prompt: "Search coins")
                }
            }
            .task {
                await viewModel.loadCoins()
            }
            .navigationDestination(isPresented: $isNavigatingToDetail) {
                if let detail = viewModel.selectedCoinDetail {
                    CoinDetailView(detail: detail)
                }
            }
        }
    }
}
