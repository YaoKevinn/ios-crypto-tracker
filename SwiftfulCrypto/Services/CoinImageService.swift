//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by YaoKevinn on 23/12/2021.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {

    @Published var image: UIImage?

    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String

    init (coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }

    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
//            print("Retrieved image from File Manager")
            image = savedImage
        } else {
//            print("Downloading image now")
            downloadCoinImage()
        }
//        downloadCoinImage()
    }

    private func downloadCoinImage() {

        guard let url = URL(string: coin.image) else { return }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let downloadedImage = returnedImage
                else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
