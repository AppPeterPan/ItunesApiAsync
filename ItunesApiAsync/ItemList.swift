//
//  ItemList.swift
//  ItunesApiAsync
//
//  Created by Peter Pan on 2022/12/1.
//

import SwiftUI

struct ItemList: View {
    @EnvironmentObject var fetcher: ItunesDataFetcher
    @State private var showError = false
    @State private var error: Error?

    var body: some View {
        List {
            ForEach(fetcher.items) { item in
                ItemRow(item: item)
            }
        }
        .task {
            if fetcher.items.isEmpty {
                do {
                    try await fetcher.fetchData(term: "張智霖")
                } catch {
                    self.error = error
                    showError = true
                }
            }
        }
        .alert(error?.localizedDescription ?? "", isPresented: $showError, actions: {
        })
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemList()
    }
}
