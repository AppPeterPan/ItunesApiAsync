//
//  ItunesDataFetcher.swift
//  ItunesApiAsync
//
//  Created by Peter Pan on 2022/12/1.
//

import Foundation

class ItunesDataFetcher: ObservableObject {
    @Published var items = [StoreItem]()
    
    enum FetchError: Error {
        case invalidURL
        case badRequest
    }
    
    func fetchData(term: String) async throws {
        let urlString = "https://itunes.apple.com/search?term=\(term)&media=music&country=tw"
        
        guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
                  throw FetchError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }
        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
        Task { @MainActor in
            items = searchResponse.results
        }
    }
}
