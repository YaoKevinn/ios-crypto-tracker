//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by YaoKevinn on 24/12/2021.
//

import Foundation
import Combine

class MarketDateService {

    @Published var marketData: MarketDataModel?

    var marketDataSubscription: AnyCancellable?

    init() {
        getData()
    }

    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }

        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                self?.marketData = returnedData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
