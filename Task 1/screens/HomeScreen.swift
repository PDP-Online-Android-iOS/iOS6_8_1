//
//  HomeScreen.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var database = RealtimeStore()
    
    @State var isLoading = false
    
    func doSignOut() {
        isLoading = true
        if SessionStore().signOut() {
            isLoading = false
            session.listen()
        }
    }
    
    func apiAllContacts() {
        isLoading = true
        database.loadContacts {
            isLoading = false
            print(database.contacts.count)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                List {
                    ForEach(database.contacts, id: \.self) { contact in
                        ContactCell(contact: contact)
                    }
                }.listStyle(PlainListStyle())
                
                if isLoading {
                    ProgressView()
                }
                
            }
            .accentColor(.red)
            .tint(Color.red)
            .navigationBarItems(trailing: HStack {
                NavigationLink(destination: AddPostScreen(), label: {
                    Image(systemName: "plus.rectangle")
                        .foregroundColor(.black)
                })
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .onTapGesture {
                        doSignOut()
                    }
            })
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            apiAllContacts()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
