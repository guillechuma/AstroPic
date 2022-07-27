//
//  NetworkManager.swift
//  AstroPic
//
//  Created by Guillermo Chumaceiro on 26/7/22.
//

import Foundation
import Combine
import SwiftUI

class NetworkManager: ObservableObject {
    
    // Date to display
    @Published var date: Date = Date()
    
    @Published var photoInfo = PhotoInfo()
    @Published var image: Image?
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // let url = URL(string: Constants.baseURL)!
        // key-value pair
        // let fullURL = url.withQuery(["api_key" : Constants.key])!
        
        $date.removeDuplicates()
            .sink { (value) in
                self.image = nil
            }
            .store(in: &subscriptions)
        
        $date.removeDuplicates()
            .map {
                self.createURL(for: $0)
            }.flatMap { (url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .decode(type: PhotoInfo.self, decoder: JSONDecoder())
                    .catch { (error) in
                        Just(PhotoInfo())
                    }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photoInfo, on: self)
            .store(in: &subscriptions)
        
        
        // Subscribe to photoInfo, and if I have a new photoInfo, new image URL
        $photoInfo
            .filter { $0.url != nil }
            .map { photoInfo -> URL in
                return photoInfo.url!
            }.flatMap { (url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .catch { error in
                        return Just(Data())
                    }
            }.map { (out) -> Image? in
                Image(uiImage: UIImage(data: out) ?? UIImage())
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
//            .sink { (completion) in
//                switch completion {
//                case .finished:
//                    print("fetch complete finished")
//                case .failure(let failure):
//                    print("fetch complete with failure: \(failure.localizedDescription)")
//                }
//            } receiveValue: { (data, response) in
//                if let description = String(data: data, encoding: .utf8) {
//                    print("fetched new data \(description)")
//                }
//            }.store(in: &subscriptions)

        // fetch data
        
    }
    
    func createURL(for date: Date) -> URL {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = formatter.string(from: date)
        
        let url = URL(string: Constants.baseURL)!
        // key-value pair
        let fullURL = url.withQuery(["api_key" : Constants.key, "date": dateString])!
        
        return fullURL
    }
}
