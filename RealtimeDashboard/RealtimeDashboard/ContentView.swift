//
//  ContentView.swift
//  RealtimeDashboard
//
//  Created by Bilven Parikh on 01/04/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = DashboardViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                if viewModel.hotList.isEmpty {
                    Text("No Items Available")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("Hot List")
                        .font(.title)
                    List {
                        ForEach(viewModel.hotList, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            viewModel.deleteHotItem(at: indexSet)
                        })
                    }
                }
                if viewModel.newList.isEmpty {
                    Text("No Items Available")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("New List")
                        .font(.title)
                    List {
                        ForEach(viewModel.newList, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            viewModel.deleteNewItem(at: indexSet)
                        })
                    }

                }
            }
            .navigationTitle("Welcome to Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            viewModel.observeDataChangesHotList()
            viewModel.observeDataChangesNewList()
        })
    }
}

#Preview {
    ContentView()
}
