//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 7.07.2022.
//
import Combine
import Foundation

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badUrlResponse(url: URL)
        case unknown
        var errorDescription: String? {
            switch self {
            case .badUrlResponse(url: let url):
               return "[🔥] Bad response from url: \(url)"
            case .unknown:
                return " [⚠️] Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data,Error> {
      return URLSession.shared.dataTaskPublisher(for: url)
             .subscribe(on: DispatchQueue.global(qos: .default))
             .tryMap({ try handleUrlResponse(output: $0, url: url) })
             .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher()
        }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw NetworkingError.badUrlResponse(url: url)
              }
        return output.data
    }
    
    static func completionHandler(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
