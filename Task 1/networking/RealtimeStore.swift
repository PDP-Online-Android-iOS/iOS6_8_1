//
//  RealtimeStore.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseDatabase

class RealtimeStore: ObservableObject {
    var ref: DatabaseReference = Database.database().reference(withPath: "contacts")
    @Published var contacts: [Contact] = []
    
    func storeContact(contact: Contact, completion: @escaping (_ success: Bool) -> ()) {
        var success = true
        let toBeSaved = ["name": contact.name!, "number": contact.number!]
        
        ref.childByAutoId().setValue(toBeSaved) { (error, response) -> Void in
            if error != nil {
                success = false
            }
        }
        completion(success)
    }
    
    func loadContacts(completion: @escaping () -> ()) {
        ref.observe(DataEventType.value) { (snapshot) in
            self.contacts = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let value = snapshot.value as? [String: AnyObject]
                    let name = value!["name"] as? String
                    let number = value!["number"] as? String
                    self.contacts.append(Contact(name: name, number: number))
                }
            }
            completion()
        }
    }
}
