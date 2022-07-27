//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 9.07.2022.
//
import Combine
import Foundation
import SwiftUI

class CoinImageService {
    @Published var image: UIImage? = nil
   
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    private let folderName = "coin_images"
    private var fileManager = LocalFileManager.instance
    private let imageName: String
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Got image from filemanager")
        } else {
            downloadCoinImage()
        }
    }
    
    
    private func downloadCoinImage() {
        print("Downloading image now")
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription =  NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.completionHandler, receiveValue: { [weak self] (receivedImage) in
                guard let self = self, let downloadedImage = receivedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName , folderName: self.folderName)

            })
    }
}
