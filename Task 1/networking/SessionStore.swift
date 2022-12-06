//
//  SessionStore.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import Foundation
import Combine
import Firebase

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet { self.didChange.send(self) } }
    var handler: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user: \(user)")
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
            } else {
                self.session = nil
            }
        }
    }
    
    
    // additional mehtods (sign up, sign in) will go here
    
    func signUp(email: String, password: String, handler: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email: String, password: String, handler: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
}
