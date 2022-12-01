//
//  ItunesApiAsyncApp.swift
//  ItunesApiAsync
//
//  Created by Peter Pan on 2022/12/1.
//

import SwiftUI

@main
struct ItunesApiAsyncApp: App {
    @StateObject private var fetcher = ItunesDataFetcher()

    var body: some Scene {
        WindowGroup {
            ItemList()
                .environmentObject(fetcher)
        }
    }
}
