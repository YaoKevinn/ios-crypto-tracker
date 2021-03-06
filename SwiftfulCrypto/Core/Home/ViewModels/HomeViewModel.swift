//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by YaoKevinn on 14/12/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings

    private let coinDataService = CoinDateService()
    private let marketDataService = MarketDateService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()

    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }

    init() {
        addSubscribers()
    }

    func addSubscribers() {
//        // UPDATES allCoins, but no longer needed cause the searchText subscriber below
//        dataService.$allCoins
//            .sink { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)

        // onValueChanges
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)

        // Updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoin in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoin)
            }
            .store(in: &cancellables)

        // Updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)

    }

    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }

    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }

    private func mapAllCoinsToPortfolioCoins(allCoin: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoin.compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }

    private func filterAndSortCoins(text: String, coins: [CoinModel], sortOption: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        // sort
        sortCoins(sort: sortOption, coins: &updatedCoins)
        return updatedCoins
    }

    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }

        let lowercaseText = text.lowercased()
        let filteredCoins = coins.filter({
            $0.name.lowercased().contains(lowercaseText) ||
            $0.symbol.lowercased().contains(lowercaseText) ||
            $0.id.lowercased().contains(lowercaseText)
        })
        return filteredCoins
    }

    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }

    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {

        // will only sort by holdings or reversedHoldings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }

    private func
        mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []

        guard let data = marketDataModel else { return stats }

        let marketCap =
            StatisticModel(
                title: "Market Cap",
                value: data.marketCap,
                percentageChange: data.marketCapChangePercentage24HUsd
            )
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)

        let portfolioValue =
                portfolioCoins
                    .map({ $0.currentHoldingsValue })
                    .reduce(0, +)

        let previousValue =
                portfolioCoins
                    .map { (coin) -> Double in
                        let currentValue = coin.currentHoldingsValue
                        let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                        let previousValue = currentValue / (1 + percentChange)
                        return previousValue
                    }
                    .reduce(0, +)

        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100

        let portfolio =
            StatisticModel(
                title: "Portfolio Value",
                value: portfolioValue.asCurrencyWith2Decimals(),
                percentageChange: percentageChange
            )

        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])

        return stats
    }

}
