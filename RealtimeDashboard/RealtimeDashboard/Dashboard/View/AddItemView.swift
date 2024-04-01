//
//  AddItemView.swift
//  RealtimeDashboard
//
//  Created by Bilven Parikh on 01/04/24.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @State private var itemName = ""
    @State private var itemDescription = ""

    var body: some View {
        VStack {
            TextField("Enter Name", text: $itemName)
                .padding()
            TextField("Enter Description", text: $itemDescription)
                .padding()
            Button("Add Item") {
                viewModel.addHotItem(name: itemName, description: itemDescription)
                itemName = ""
                itemDescription = ""
            }
            .padding()
        }
        .navigationBarTitle("Add Item")
    }
}


#Preview {
    AddItemView(viewModel: DashboardViewModel())
}
