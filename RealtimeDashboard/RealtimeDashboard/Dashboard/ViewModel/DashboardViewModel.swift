//
//  DashboardViewModel.swift
//  RealtimeDashboard
//
//  Created by Bilven Parikh on 01/04/24.
//

import UIKit
import Foundation
import Firebase
import Combine
import FirebaseDatabase

class DashboardViewModel: ObservableObject {

    //Lists of Dashboard items
    @Published var hotList: [Item] = []
    @Published var newList: [Item] = []

    //DB helpers
    private var hotlistDB = Database.database().reference().child("hot_list")
    private var newlistDB = Database.database().reference().child("new_list")
    private var cancellables: Set<AnyCancellable> = []
    private var dataSubjectHotList = PassthroughSubject<DataSnapshot, Never>()
    private var dataSubjectNewList = PassthroughSubject<DataSnapshot, Never>()

    //Observes and updates Hot List from DB
    func observeDataChangesHotList() {
        hotlistDB.observe(.value) { snapshot in
            self.dataSubjectHotList.send(snapshot)
        }

        dataSubjectHotList
            .map { snapshot -> [Item] in
                guard let value = snapshot.value as? [String: Any] else { return [] }
                return value.compactMap { key, data in
                    guard let data = data as? [String: Any],
                          let name = data["name"] as? String,
                          let description = data["description"] as? String else {
                        return nil
                    }
                    return Item(id: key, name: name, description: description)
                }
            }
            .assign(to: &$hotList)
    }

    //Observes and updates New List from DB
    func observeDataChangesNewList() {
        newlistDB.observe(.value) { snapshot in
            self.dataSubjectNewList.send(snapshot)
        }

        dataSubjectNewList
            .map { snapshot -> [Item] in
                guard let value = snapshot.value as? [String: Any] else { return [] }
                return value.compactMap { key, data in
                    guard let data = data as? [String: Any],
                          let name = data["name"] as? String,
                          let description = data["description"] as? String else {
                        return nil
                    }
                    return Item(id: key, name: name, description: description)
                }
            }
            .assign(to: &$newList)
    }

    // Optional methods: If want to add/delete items
    
    func addHotItem(name: String, description: String) {
        let newItemRef = hotlistDB.childByAutoId()
        let newItem = ["name": name, "description": description]
        newItemRef.setValue(newItem)
    }

    func addNewItem(name: String, description: String) {
        let newItemRef = newlistDB.childByAutoId()
        let newItem = ["name": name, "description": description]
        newItemRef.setValue(newItem)
    }

    func deleteHotItem(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { hotList[$0] }
        for item in itemsToDelete {
            let itemRef = hotlistDB.child(item.id)
            itemRef.removeValue()
        }
    }

    func deleteNewItem(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { newList[$0] }
        for item in itemsToDelete {
            let itemRef = newlistDB.child(item.id)
            itemRef.removeValue()
        }
    }

}

